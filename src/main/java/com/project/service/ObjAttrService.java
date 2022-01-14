package com.project.service;

import com.project.entity.ObjAttr;
import com.project.repository.ObjAttrRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ObjAttrService {

    @Autowired
    private ObjAttrRepository objAttrRepository;

    public List<ObjAttr> findAll(){
        return objAttrRepository.findAll();
    }

}
