package com.project.repository;

import com.project.entity.Obj;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ObjRepository extends JpaRepository<Obj, Integer> {

    public List<Obj> findByObjectType_ObjTypesName(String objType);

}
