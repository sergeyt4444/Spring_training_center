package com.project.service;

import com.project.entity.*;
import com.project.repository.AttributeRepository;
import com.project.repository.ObjAttrRepository;
import com.project.repository.ObjRepository;
import com.project.repository.ObjectTypeRepository;
import liquibase.pro.packaged.A;
import liquibase.pro.packaged.O;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
        if (parentId == null) {
            parentId = "0";
        }
        return objRepository.findAllByObjectTypeAndParentId(objType, parentId);
    }

    public List<Obj> findByObjTypeAndParentId(ObjectTypeEnum objectTypeEnum, String parentId) {
        if (parentId == null) {
            parentId = "0";
        }
        return objRepository.findAllByObjectTypeAndParentId(objectTypeEnum.getValue(), parentId);
    }

    public int createObj(Map<Integer, String> mappedObj) {
        Obj obj = new Obj();
        obj.setObjectType(objectTypeRepository.getById(ObjectTypeEnum.COURSE.getValue()));
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
        return 0;
    }


}
