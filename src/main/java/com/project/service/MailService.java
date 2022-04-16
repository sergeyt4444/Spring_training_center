package com.project.service;

import com.project.entity.Obj;
import com.project.entity.ObjectTypeEnum;
import com.project.events.FullCapacityEvent;
import com.project.tools.ObjectConverter;
import com.sun.jersey.api.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class MailService {

    private static final String SERVER_URL = "http://localhost:8180/auth";
    private static final String REALM = "myrealm";
    private static final String USERNAME = "admin";
    private static final String PASSWORD = "admin";
    private static final String CLIENT_ID = "admin-cli";

    @Autowired
    private ObjService objService;


    @Autowired
    private ApplicationEventPublisher applicationEventPublisher;

    public void sendMailNotifications(int courseId) {
        Obj obj = objService.findById(courseId).orElseThrow(
                () -> new NotFoundException());
        Map<Integer, String> mappedObj = ObjectConverter.convertObject(obj);
        if (obj.getObjectType().getObjTypesId() == ObjectTypeEnum.COURSE.getValue()) {
            FullCapacityEvent fullCapacityEvent = new FullCapacityEvent(this, mappedObj);
            applicationEventPublisher.publishEvent(fullCapacityEvent);
        }
    }


}
