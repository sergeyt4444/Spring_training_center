package com.project.repository;

import com.project.entity.ObjectType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface ObjectTypeRepository extends JpaRepository<ObjectType, Integer> {



}