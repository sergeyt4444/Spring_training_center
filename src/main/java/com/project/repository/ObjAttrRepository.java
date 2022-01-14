package com.project.repository;

import com.project.entity.ObjAttr;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ObjAttrRepository extends JpaRepository<ObjAttr, Integer> {
}
