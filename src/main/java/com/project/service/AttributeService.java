package com.project.service;

import com.project.entity.Attribute;
import com.project.repository.AttributeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AttributeService {

    @Autowired
    private AttributeRepository attributeRepository;

    public List<Attribute> findAll(){
        return attributeRepository.findAll();
    }

}
