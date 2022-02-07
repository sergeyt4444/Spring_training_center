package com.project.service;

import com.project.entity.Obj;
import com.project.entity.ObjAttr;
import com.project.entity.ObjectType;
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

    public List<Obj> findByObjType(String objType) {
        return objRepository.findByObjectType_ObjTypesName(objType);
    }

    public List<Obj> findMainCategories() {
        List<Obj> list = findByObjType("course");
        List<Obj> result = new ArrayList<>();
        for (Obj obj: list) {
            int flag = 0;
            for (ObjAttr objAttr:obj.getObjAttrs()) {
                if (objAttr.getAttribute().getAttrName().equals("parent ID")
                        && objAttr.getValue()==null) {
                    flag = 1;
                }
            }
            if (flag == 1) {
                result.add(obj);
            }
        }
        return result;
    }

}
