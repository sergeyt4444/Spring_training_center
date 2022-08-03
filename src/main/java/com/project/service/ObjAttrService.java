package com.project.service;

import com.project.entity.Attribute;
import com.project.entity.Obj;
import com.project.entity.ObjAttr;
import com.project.repository.AttributeRepository;
import com.project.repository.ObjAttrRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityNotFoundException;
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

    public ObjAttr findByAttrNameAndObjId(String attrName, int objId) {
        return objAttrRepository.findByAttribute_AttrNameAndObjId(attrName, objId);
    }

    public void createObjAttr(Map<String, String> mappedObjAttr, Obj obj) {
        if (obj == null) {
            return;
        }
        Attribute attribute = attributeRepository.findByAttrName(mappedObjAttr.get("name"));

        if (attribute == null) {
            attribute = new Attribute();
            attribute.setAttrName(mappedObjAttr.get("name"));
            attribute.setAttrType(mappedObjAttr.get("type"));
            attribute.setHidden(Boolean.parseBoolean(mappedObjAttr.get("isHidden")));
            attribute.setMultiple(Boolean.parseBoolean(mappedObjAttr.get("isMultiple")));
        }

        ObjAttr objAttr = objAttrRepository.findByAttribute_AttrNameAndObjId(mappedObjAttr.get("name"), obj.getObjId());
        if (objAttr == null) {
            objAttr = new ObjAttr();
            objAttr.setAttribute(attribute);
            objAttr.setValue(mappedObjAttr.get("value"));
            objAttr.setObjId(obj.getObjId());
        }
        else {
            objAttr.setValue(mappedObjAttr.get("value"));
        }

        objAttrRepository.save(objAttr);
    }

    public void changeObjAttrBulk(List<Map<String, String>> mappedObjAttrs) {
        for (Map<String, String> mappedObjAttr: mappedObjAttrs) {
            ObjAttr objAttr = objAttrRepository.findByAttribute_AttrNameAndObjId(mappedObjAttr.get("name"),
                    Integer.parseInt(mappedObjAttr.get("objId")));
            objAttr.setValue(mappedObjAttr.get("value"));
            objAttrRepository.save(objAttr);
        }
    }

    public void changeObjAttr(Map<String, String> mappedObjAttr, Obj obj) {
        ObjAttr objAttr = objAttrRepository.findByAttribute_AttrNameAndObjId(mappedObjAttr.get("name"), obj.getObjId());
        if (objAttr != null) {
            objAttr.setValue(mappedObjAttr.get("value"));

            objAttrRepository.save(objAttr);
        }
    }

    public void delete(ObjAttr objAttr) {
        if (objAttr != null) {
            objAttrRepository.delete(objAttr);
        }
    }

}
