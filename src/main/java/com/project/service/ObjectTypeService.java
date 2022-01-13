package com.project.service;

import com.project.entity.Attribute;
import com.project.entity.ObjectType;
import com.project.repository.AttributeRepository;
import com.project.repository.ObjectTypeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ObjectTypeService {

    @Autowired
    private ObjectTypeRepository objectTypeRepository;

    public List<ObjectType> findAll(){
        return objectTypeRepository.findAll();
    }

}
