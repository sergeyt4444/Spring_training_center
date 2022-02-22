package com.project.controller;

import com.project.entity.Attribute;
import com.project.entity.Obj;
import com.project.entity.ObjAttr;
import com.project.entity.ObjectTypeEnum;
import com.project.misc.MiscTool;
import com.project.service.AttributeService;
import com.project.service.ObjAttrService;
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

import java.util.HashMap;
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

    @Autowired
    private ObjAttrService objAttrService;

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

    @PreAuthorize("hasRole('MODERATOR')")
    @PostMapping("/objattrs")
    public ResponseEntity createObjAttr(@RequestBody Map<String, String> mappedObjAttr) {
        Obj obj = objService.findById(Integer.parseInt(mappedObjAttr.get("objId"))).orElse(new Obj());
        objAttrService.createObjAttr(mappedObjAttr, obj);
        return new ResponseEntity(HttpStatus.NO_CONTENT);
    }

    @PreAuthorize("hasRole('MODERATOR')")
    @PutMapping("/objattrs")
    public ResponseEntity changeObjAttr(@RequestBody Map<String, String> mappedObjAttr) {
        Obj obj = objService.findById(Integer.parseInt(mappedObjAttr.get("objId"))).orElse(new Obj());
        objAttrService.changeObjAttr(mappedObjAttr, obj);
        return new ResponseEntity(HttpStatus.NO_CONTENT);
    }

    @PreAuthorize("hasRole('USER')")
    @PutMapping("/usercourses")
    public ResponseEntity addUserCourse(@RequestBody Map<String, String> mappedObjAttr) {
        if (MiscTool.accesibleByUsersAttrs.contains(mappedObjAttr.get("name"))) {
            Obj obj = objService.findById(Integer.parseInt(mappedObjAttr.get("objId"))).orElse(new Obj());
            objAttrService.createObjAttr(mappedObjAttr, obj);
            return new ResponseEntity(HttpStatus.NO_CONTENT);
        }
        else {
            return new ResponseEntity(HttpStatus.FORBIDDEN);
        }
    }

    @PreAuthorize("hasRole('MODERATOR')")
    @DeleteMapping("objattrs/{id}")
    public Map<String, Boolean> deleteObjAttr(@PathVariable (value = "id")Integer id) {
        ObjAttr objAttr = objAttrService.findById(id).orElseThrow( () ->
                new NotFoundException());
        objAttrService.delete(objAttr);

        Map<String, Boolean> response = new HashMap<>();
        response.put("deleted", true);
        return response;
    }

    @PreAuthorize("hasRole('USER')")
    @GetMapping("users/{name}")
    public ResponseEntity getUser(@PathVariable (value = "name") String username) {
        return ResponseEntity.ok(objService.findByObjTypeAndUsername(ObjectTypeEnum.USER.getValue(), username));
    }


}
