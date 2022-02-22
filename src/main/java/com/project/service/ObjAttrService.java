package com.project.service;

import com.project.entity.Attribute;
import com.project.entity.Obj;
import com.project.entity.ObjAttr;
import com.project.repository.AttributeRepository;
import com.project.repository.ObjAttrRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class ObjAttrService {

    @Autowired
    private ObjAttrRepository objAttrRepository;

    @Autowired
    private AttributeRepository attributeRepository;

    public List<ObjAttr> findAll(){
        return objAttrRepository.findAll();
    }

    public Optional<ObjAttr> findById(int id) {
        return objAttrRepository.findById(id);
    }

    public void createObjAttr(Map<String, String> mappedObjAttr, Obj obj) {

        Attribute attribute = new Attribute();
        attribute.setAttrName(mappedObjAttr.get("name"));
        attribute.setAttrType(mappedObjAttr.get("type"));
        attribute.setHidden(Boolean.parseBoolean(mappedObjAttr.get("isHidden")));
        attribute.setMultiple(Boolean.parseBoolean(mappedObjAttr.get("isMultiple")));

        ObjAttr objAttr = new ObjAttr();
        objAttr.setAttribute(attribute);
        objAttr.setValue(mappedObjAttr.get("value"));
        objAttr.setObjId(obj.getObjId());

        objAttrRepository.save(objAttr);
    }

    public void changeObjAttr(Map<String, String> mappedObjAttr, Obj obj) {
        ObjAttr objAttr = objAttrRepository.findByAttribute_AttrNameAndObjId(mappedObjAttr.get("name"), obj.getObjId());
        objAttr.setValue(mappedObjAttr.get("value"));

        objAttrRepository.save(objAttr);
    }

        public void delete(ObjAttr objAttr) {
        objAttrRepository.delete(objAttr);
    }

}
