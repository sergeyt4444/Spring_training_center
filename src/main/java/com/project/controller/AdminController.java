package com.project.controller;

import com.project.entity.AttrEnum;
import com.project.entity.Attribute;
import com.project.entity.Obj;
import com.project.entity.ObjectTypeEnum;
import com.project.misc.MiscTool;
import com.project.service.AttributeService;
import com.project.service.ObjAttrService;
import com.project.service.ObjService;
import com.project.service.ObjectTypeService;
import com.project.tools.AttributeTool;
import com.project.tools.ObjectConverter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.persistence.EntityNotFoundException;
import javax.xml.ws.http.HTTPException;
import java.util.Arrays;
import java.util.HashMap;
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
        try {
            objAttrService.changeObjAttrBulk(mappedObjAttrs);
            return new ResponseEntity(HttpStatus.NO_CONTENT);
        }
        catch (EntityNotFoundException e) {
            return new ResponseEntity(HttpStatus.NO_CONTENT);
        }
    }

    @GetMapping("/attributes")
    public ResponseEntity<List<Attribute>> getAttributes() {
        return ResponseEntity.ok(attributeService.findAll());
    }

    @GetMapping("/attributes/{id}")
    public ResponseEntity<List<Attribute>> getAttributesByObjTypeId(@PathVariable(value = "id")Integer objTypeId) {
        return ResponseEntity.ok(objectTypeService.findAttributesByObjectType(objTypeId));
    }

    @DeleteMapping("courses/{id}")
    public ResponseEntity<Map<String, Boolean>> deleteObj(@PathVariable (value = "id")Integer id) {
        try {
            Obj obj = objService.findById(id).orElseThrow(
                    () -> new HTTPException(404)
            );
            objService.deleteObj(obj);

            Map<String, Boolean> response = new HashMap<>();
            response.put("deleted", true);
            return ResponseEntity.ok(response);
        }
        catch (HTTPException e) {
            Map<String, Boolean> response = new HashMap<>();
            response.put("deleted", false);
            return new ResponseEntity<>(
                    response, new HttpHeaders(), HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping("users")
    public ResponseEntity<List<Obj>> getUsers(@RequestParam(defaultValue = "1") Integer page,
                                              @RequestParam(defaultValue = "10") Integer pageSize) {
        return ResponseEntity.ok(objService.findbyObjTypeId(ObjectTypeEnum.USER.getValue(), page, pageSize));
    }


    @GetMapping("users/count")
    public int getUsersCount() {
        return objService.countByObjTypeId(ObjectTypeEnum.USER.getValue());
    }


}
