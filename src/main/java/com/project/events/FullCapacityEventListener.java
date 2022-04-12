package com.project.events;

import com.project.entity.AttrEnum;
import com.project.entity.Obj;
import com.project.service.ObjService;
import com.project.tools.ObjectConverter;
import com.sun.jersey.api.NotFoundException;
import org.jboss.resteasy.client.jaxrs.ResteasyClientBuilder;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.admin.client.KeycloakBuilder;
import org.keycloak.admin.client.resource.UserResource;
import org.keycloak.admin.client.resource.UsersResource;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

@Component
public class FullCapacityEventListener implements ApplicationListener<FullCapacityEvent> {

    @Autowired
    private JavaMailSender emailSender;

    @Autowired
    private ObjService objService;

    private static final String SERVER_URL = "http://localhost:8180/auth";
    private static final String REALM = "myrealm";
    private static final String USERNAME = "admin";
    private static final String PASSWORD = "admin";
    private static final String CLIENT_ID = "admin-cli";

    @Override
    public void onApplicationEvent(FullCapacityEvent event) {
        String subscriberString = event.getMappedCourse().get(AttrEnum.SUBSCRIBERS.getValue());
        List<String> subscribers = Arrays.asList(subscriberString.split(";"));
        Keycloak keycloak = KeycloakBuilder
                .builder()
                .serverUrl(SERVER_URL)
                .realm("master")
                .username(USERNAME)
                .password(PASSWORD)
                .clientId(CLIENT_ID)
                .resteasyClient(new ResteasyClientBuilder().connectionPoolSize(10).build())
                .build();
        UsersResource usersResource = keycloak.realm(REALM).users();
        for (String subscriber: subscribers) {
            Obj subUser = objService.findById(Integer.parseInt(subscriber)).orElseThrow(
                    () -> new NotFoundException());
            Map<Integer, String> mappedSubUser = ObjectConverter.convertObject(subUser);
            UserRepresentation userRepresentation = usersResource.search(mappedSubUser.get(AttrEnum.USER_NAME.getValue())).get(0);

            sendMailNotification(event.getMappedCourse(), userRepresentation.getEmail());
        }
    }

    private void sendMailNotification(Map<Integer, String> mappedObj, String email) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("noreply@baeldung.com");
        message.setTo(email);
        message.setSubject("One of your courses has enough participants");
        message.setText("Your course " + mappedObj.get(AttrEnum.COURSE_NAME.getValue()) +
                " has reached " + mappedObj.get(AttrEnum.PARTICIPANTS_REQUIRED.getValue()) +
                " participants!");
        emailSender.send(message);
    }

}
