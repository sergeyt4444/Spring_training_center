package com.project;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.netflix.discovery.EurekaClient;
import com.project.service.AttributeService;
import com.project.service.ObjAttrService;
import com.project.service.ObjService;
import com.project.service.ObjectTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Lazy;

@SpringBootApplication
public class Application implements CommandLineRunner {

    @Autowired
    private AttributeService attributeService;
    @Autowired
    private ObjService objService;
    @Autowired
    private ObjectTypeService objectTypeService;
    @Autowired
    private ObjAttrService objAttrService;

    public static void main(String[] args) {
        SpringApplication.run(Application.class);
    }


    @Override
    public void run(String... args) throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        System.out.println("attributes: ");
        attributeService.findAll().forEach(System.out::println);
        System.out.println("attributes serialized: ");
        System.out.println(objectMapper.writeValueAsString(attributeService.findAll()));
        System.out.println("-------------------------------------------");
        System.out.println("objects: ");
        objService.findAll().forEach(System.out::println);
        System.out.println("objects serialized: ");
        System.out.println(objectMapper.writeValueAsString(objService.findAll()));
        System.out.println("-------------------------------------------");
        System.out.println("object types: ");
        objectTypeService.findAll().forEach(System.out::println);
        System.out.println("object types serialized: ");
        System.out.println(objectMapper.writeValueAsString(objectTypeService.findAll()));
        System.out.println("-------------------------------------------");
        System.out.println("object-attribute list: ");
        objAttrService.findAll().forEach(System.out::println);
        System.out.println("object-attribute list serialized: ");
        System.out.println(objectMapper.writeValueAsString(objAttrService.findAll()));

    }

    }
