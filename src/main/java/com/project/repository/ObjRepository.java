package com.project.repository;

import com.project.entity.Obj;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ObjRepository extends JpaRepository<Obj, Integer> {
}
