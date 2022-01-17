package com.project.service;

import com.project.entity.Obj;
import com.project.entity.ObjectType;
import com.project.repository.ObjRepository;
import com.project.repository.ObjectTypeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ObjService {

    @Autowired
    private ObjRepository objRepository;

    public List<Obj> findAll(){
        return objRepository.findAll();
    }

}
