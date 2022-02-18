package com.project.repository;

import com.project.entity.Obj;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ObjRepository extends JpaRepository<Obj, Integer> {

    public List<Obj> findAllByObjectType_ObjTypesId(int objId);

    @Query("select obj from Obj obj join obj.objAttrs objAttr where (obj.objectType.objTypesId = :objId) "
            + "and (objAttr.value = :parentId) and (objAttr.attribute.attrId = 3)")
    public List<Obj> findAllByObjectTypeAndParentId(@Param("objId")int objId, @Param("parentId")String parentId);

    @Query("select obj from Obj obj join obj.objAttrs objAttr where (obj.objectType.objTypesId = :objId) "
            + "and (objAttr.value = :courseName) and (objAttr.attribute.attrId = 1)")
    public List<Obj> findByObjectTypeAndName(@Param("objId")int objId, @Param("courseName")String courseName);

}
