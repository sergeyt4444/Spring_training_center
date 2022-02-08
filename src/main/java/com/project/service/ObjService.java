package com.project.service;

import com.project.entity.Obj;
import com.project.entity.ObjAttr;
import com.project.entity.ObjectType;
import com.project.entity.ObjectTypeEnum;
import com.project.repository.ObjRepository;
import com.project.repository.ObjectTypeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ObjService {

    @Autowired
    private ObjRepository objRepository;

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
        return objRepository.findAllByObjectTypeAndParentId(objType, parentId);
    }

    public List<Obj> findByObjTypeAndParentId(ObjectTypeEnum objectTypeEnum, String parentId) {
        return objRepository.findAllByObjectTypeAndParentId(objectTypeEnum.getValue(), parentId);
    }



}
