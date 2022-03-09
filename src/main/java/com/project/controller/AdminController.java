package com.project.controller;

import com.project.entity.Attribute;
import com.project.entity.ObjectTypeEnum;
import com.project.service.AttributeService;
import com.project.service.ObjAttrService;
import com.project.service.ObjService;
import com.project.service.ObjectTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/admin")
@PreAuthorize("hasRole('ADMIN')")
public class AdminController {


    @Autowired
    private AttributeService attributeService;

    @Autowired
    private ObjectTypeService objectTypeService;

    @Autowired
    private ObjService objService;

    @Autowired
    private ObjAttrService objAttrService;


    @PostMapping("/categories")
    public ResponseEntity createCategory(@RequestBody Map<Integer, String> mappedObj) {
        objService.createObj(mappedObj, ObjectTypeEnum.CATEGORY.getValue());
        return new ResponseEntity(HttpStatus.NO_CONTENT);
    }

    @PostMapping("/courses")
    public ResponseEntity createCourse(@RequestBody Map<Integer, String> mappedObj) {
        objService.createObj(mappedObj, ObjectTypeEnum.COURSE.getValue());
        return new ResponseEntity(HttpStatus.NO_CONTENT);
    }

    @PutMapping("courses")
    public ResponseEntity editCourse(@RequestBody List<Map<String, String>> mappedObjAttrs) {
        objAttrService.changeObjAttrBulk(mappedObjAttrs);
        return new ResponseEntity(HttpStatus.NO_CONTENT);
    }

    @GetMapping("/attributes")
    public ResponseEntity<List<Attribute>> getAttributes() {
        return ResponseEntity.ok(attributeService.findAll());
    }

    @GetMapping("/attributes/{id}")
    public ResponseEntity<List<Attribute>> getAttributesByObjTypeId(@PathVariable(value = "id")Integer objTypeId) {
        return ResponseEntity.ok(objectTypeService.findAttributesByObjectType(objTypeId));
    }

}
