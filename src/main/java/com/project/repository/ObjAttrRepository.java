package com.project.repository;

import com.project.entity.Obj;
import com.project.entity.ObjAttr;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ObjAttrRepository extends JpaRepository<ObjAttr, Integer> {

    public ObjAttr findByAttribute_AttrNameAndObjId(String attrName, int objId);


}
