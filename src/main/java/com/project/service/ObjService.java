package com.project.service;

import com.project.entity.*;
import com.project.repository.AttributeRepository;
import com.project.repository.ObjAttrRepository;
import com.project.repository.ObjRepository;
import com.project.repository.ObjectTypeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class ObjService {

    @Autowired
    private ObjRepository objRepository;

    @Autowired
    private ObjectTypeRepository objectTypeRepository;

    @Autowired
    private AttributeRepository attributeRepository;

    @Autowired
    private ObjAttrRepository objAttrRepository;

    public List<Obj> findAll(){
        return objRepository.findAll();
    }

    public List<Obj> findByObjTypeId(int objType) {
        return objRepository.findAllByObjectType_ObjTypesId(objType);
    }

    public List<Obj> findByObjTypeId(ObjectTypeEnum objectTypeEnum) {
        return objRepository.findAllByObjectType_ObjTypesId(objectTypeEnum.getValue());
    }

    public List<Obj> findByObjTypeAndParentId(int objType, String parentId) {
        parentId = validateParentId(parentId);
        return objRepository.findAllByObjectTypeAndParentId(objType, parentId);
    }

    public Obj findByObjTypeAndName(int objType, String name) {
        name = validateName(name);
        return objRepository.findByObjectTypeAndName(objType, name).get(0);
    }

    public Obj findByObjTypeAndName(ObjectTypeEnum objectTypeEnum, String name) {
        name = validateName(name);
        return objRepository.findByObjectTypeAndName(objectTypeEnum.getValue(), name).get(0);
    }

    public Obj findByObjTypeAndUsername(int objType, String username) {
        username = validateName(username);
        return objRepository.findByObjectTypeAndUsername(objType, username).get(0);
    }

    public Obj findByObjTypeAndUsername(ObjectTypeEnum objectTypeEnum, String username) {
        username = validateName(username);
        return objRepository.findByObjectTypeAndUsername(objectTypeEnum.getValue(), username).get(0);
    }

    public List<Obj> findByObjTypeAndParentId(ObjectTypeEnum objectTypeEnum, String parentId) {
        parentId = validateParentId(parentId);
        return objRepository.findAllByObjectTypeAndParentId(objectTypeEnum.getValue(), parentId);
    }

    public Optional<Obj> findById(int id) {
        return objRepository.findById(id);
    }

    public void createObj(Map<Integer, String> mappedObj, int objTypeId) {
        Obj obj = new Obj();
        obj.setObjectType(objectTypeRepository.getById(objTypeId));
        List<ObjAttr> objAttrList = new ArrayList<>();
        for (Map.Entry<Integer, String> entry: mappedObj.entrySet())
        {
            Attribute attr = attributeRepository.getById(entry.getKey());
            ObjAttr objAttr = new ObjAttr();
            objAttr.setAttribute(attr);
            objAttr.setValue(entry.getValue());
            objAttrList.add(objAttr);
        }
        obj.setObjAttrs(objAttrList);
        objRepository.save(obj);
    }

    public List<Obj> findFilteredObjects(int objId, String parentId, List<String> difficulties,
                                         List<String> languages, List<String> formats) {
        return objRepository.findFilteredObjects(objId, parentId, difficulties, languages, formats);
    }

    private String validateParentId(String parentId) {
        if (parentId == null) {
            return  "0";
        }
        return parentId;
    }

    private String validateName(String name) {
        if (name == null) {
            return "";
        }
        return name;
    }

}
