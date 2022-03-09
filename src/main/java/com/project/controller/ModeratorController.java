package com.project.controller;

import com.project.entity.Obj;
import com.project.entity.ObjAttr;
import com.project.service.ObjAttrService;
import com.project.service.ObjService;
import com.sun.jersey.api.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/moderator")
@PreAuthorize("hasRole('MODERATOR')")
public class ModeratorController {

    @Autowired
    private ObjService objService;

    @Autowired
    private ObjAttrService objAttrService;

    @PostMapping("/objattrs")
    public ResponseEntity createObjAttr(@RequestBody Map<String, String> mappedObjAttr) {
        Obj obj = objService.findById(Integer.parseInt(mappedObjAttr.get("objId"))).orElse(new Obj());
        objAttrService.createObjAttr(mappedObjAttr, obj);
        return new ResponseEntity(HttpStatus.NO_CONTENT);
    }

    @PutMapping("/objattrs")
    public ResponseEntity changeObjAttr(@RequestBody Map<String, String> mappedObjAttr) {
        Obj obj = objService.findById(Integer.parseInt(mappedObjAttr.get("objId"))).orElse(new Obj());
        objAttrService.changeObjAttr(mappedObjAttr, obj);
        return new ResponseEntity(HttpStatus.NO_CONTENT);
    }

    @DeleteMapping("objattrs/{id}")
    public Map<String, Boolean> deleteObjAttr(@PathVariable (value = "id")Integer id) {
        ObjAttr objAttr = objAttrService.findById(id).orElseThrow( () ->
                new NotFoundException());
        objAttrService.delete(objAttr);

        Map<String, Boolean> response = new HashMap<>();
        response.put("deleted", true);
        return response;
    }
}
