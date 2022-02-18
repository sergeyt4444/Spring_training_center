package com.project.controller;

import com.project.entity.Attribute;
import com.project.entity.Obj;
import com.project.entity.ObjectTypeEnum;
import com.project.service.AttributeService;
import com.project.service.ObjService;
import com.project.service.ObjectTypeService;
import com.sun.jersey.api.NotFoundException;
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
        return ResponseEntity.ok(objService.findByObjTypeAndParentId(ObjectTypeEnum.CATEGORY, "0"));
    }

    @PreAuthorize("hasRole('USER')")
    @GetMapping("category/{name}")
    public ResponseEntity<Obj> getCategoryByName(@PathVariable(value = "name")String name) {
        return ResponseEntity.ok(objService.findByObjTypeAndName(ObjectTypeEnum.CATEGORY, name));
    }

    @PreAuthorize("hasRole('USER')")
    @GetMapping("categories/{pid}")
    public ResponseEntity<List<Obj>> getSubCategories(@PathVariable(value = "pid")Integer parentId) {
        return ResponseEntity.ok(objService.findByObjTypeAndParentId(ObjectTypeEnum.CATEGORY, parentId.toString()));
    }

    @PreAuthorize("hasRole('USER')")
    @GetMapping("object_by_id/{id}")
    public ResponseEntity<Obj> getObjectById(@PathVariable(value = "id")Integer id) {
        Obj obj = objService.findById(id).orElseThrow(
                () -> new NotFoundException()
        );
        return ResponseEntity.ok(obj);
    }

    @PreAuthorize("hasRole('USER')")
    @GetMapping("courses/{pid}")
    public ResponseEntity<List<Obj>> getCourses(@PathVariable(value = "pid")Integer parentId) {
        return ResponseEntity.ok(objService.findByObjTypeAndParentId(ObjectTypeEnum.COURSE, parentId.toString()));
    }

    @PreAuthorize("hasRole('ADMIN')")
    @PostMapping("/categories")
    public ResponseEntity createCategory(@RequestBody Map<Integer, String> mappedObj) {
        System.out.println(mappedObj);
        objService.createObj(mappedObj, ObjectTypeEnum.CATEGORY.getValue());
        return new ResponseEntity(HttpStatus.NO_CONTENT);
    }

    @PreAuthorize("hasRole('ADMIN')")
    @PostMapping("/courses")
    public ResponseEntity createCourse(@RequestBody Map<Integer, String> mappedObj) {
        System.out.println(mappedObj);
        objService.createObj(mappedObj, ObjectTypeEnum.COURSE.getValue());
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
