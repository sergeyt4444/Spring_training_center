package com.project.controller;

import com.project.entity.Attribute;
import com.project.entity.Obj;
import com.project.entity.ObjectTypeEnum;
import com.project.service.AttributeService;
import com.project.service.ObjService;
import com.project.service.ObjectTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class MainController {

    @Autowired
    private ObjService objService;

    @Autowired
    private AttributeService attributeService;

    @Autowired
    private ObjectTypeService objectTypeService;

    @GetMapping("/anonymous")
    public String getAnonymousInfo() {
        return "Anonymous";
    }

    @GetMapping("/user")
    @PreAuthorize("hasRole('USER')")
    public String getUserInfo() {
        return "user info";
    }

    @GetMapping("/admin")
    @PreAuthorize("hasRole('ADMIN')")
    public String getAdminInfo() {
        return "admin info";
    }

    @GetMapping("/me")
    public Object getMe() {
        final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        return authentication.getName();
    }

    @PreAuthorize("hasRole('USER')")
    @GetMapping("/main_categories")
    public ResponseEntity<List<Obj>> getMainCategories() {
        return ResponseEntity.ok(objService.findByObjTypeAndParentId(ObjectTypeEnum.COURSE, "0"));
    }

    @PreAuthorize("hasRole('ADMIN')")
    @PostMapping("/courses")
    public ResponseEntity createObj(@RequestBody Map<Integer, String> mappedObj) {
        System.out.println(mappedObj);
        objService.createObj(mappedObj);
        return new ResponseEntity(HttpStatus.NO_CONTENT);
    }

    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("/attributes")
    public ResponseEntity<List<Attribute>> getAttributes() {
        return ResponseEntity.ok(attributeService.findAll());
    }

    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("/attributes/{id}")
    public ResponseEntity<List<Attribute>> getAttributesByObjTypeId(@PathVariable(value = "id")Integer objTypeId) {
        return ResponseEntity.ok(objectTypeService.findAttributesByObjectType(objTypeId));
    }


}
