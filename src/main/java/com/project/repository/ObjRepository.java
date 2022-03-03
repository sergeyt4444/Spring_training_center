package com.project.repository;

import com.project.entity.Obj;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
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
    public List<Obj> findAllByObjectTypeAndParentId(@Param("objId")int objId, @Param("parentId")String parentId,
                                                    Pageable pageable);
    @Query("select obj from Obj obj join obj.objAttrs objAttr where (obj.objectType.objTypesId = :objId) "
            + "and (objAttr.value = :parentId) and (objAttr.attribute.attrId = 3)")
    public List<Obj> findAllByObjectTypeAndParentId(@Param("objId")int objId, @Param("parentId")String parentId);

    @Query("select COUNT(obj) from Obj obj join obj.objAttrs objAttr where (obj.objectType.objTypesId = :objId) "
            + "and (objAttr.value = :parentId) and (objAttr.attribute.attrId = 3)")
    public int countAllByObjectTypeAndParentId(@Param("objId")int objId, @Param("parentId")String parentId);

    @Query("select obj from Obj obj join obj.objAttrs objAttr where (obj.objectType.objTypesId = :objId) "
            + "and (objAttr.value = :courseName) and (objAttr.attribute.attrId = 1)")
    public List<Obj> findByObjectTypeAndName(@Param("objId")int objId, @Param("courseName")String courseName);

    @Query("select obj from Obj obj join obj.objAttrs objAttr where (obj.objectType.objTypesId = :objId) "
            + "and (objAttr.value = :username) and (objAttr.attribute.attrId = 500)")
    public List<Obj> findByObjectTypeAndUsername(@Param("objId")int objId, @Param("username")String username);

    @Query("select obj from Obj obj join obj.objAttrs pidObjAttr join obj.objAttrs difObjAttr join obj.objAttrs langObjAttr"
            + " join obj.objAttrs formatObjAttr where (obj.objectType.objTypesId = :objId) " +
            "and (pidObjAttr.value =:parentId) and (pidObjAttr.attribute.attrId = 3)" +
            "and (difObjAttr.value in :difList) and (difObjAttr.attribute.attrId = 7)" +
            " and (langObjAttr.value in :langList) and (langObjAttr.attribute.attrId = 8)" +
            " and (formatObjAttr.value in :formatList) and (formatObjAttr.attribute.attrId = 9)")
    public List<Obj> findFilteredObjects(@Param("objId")int objId, @Param("parentId")String parentId,
                                         @Param("difList")List<String> difficulties,
                                         @Param("langList")List<String> languages,
                                         @Param("formatList")List<String> formats,
                                         Pageable pageable);

    @Query("select count(obj) from Obj obj join obj.objAttrs pidObjAttr join obj.objAttrs difObjAttr join obj.objAttrs langObjAttr"
            + " join obj.objAttrs formatObjAttr where (obj.objectType.objTypesId = :objId) " +
            "and (pidObjAttr.value =:parentId) and (pidObjAttr.attribute.attrId = 3)" +
            "and (difObjAttr.value in :difList) and (difObjAttr.attribute.attrId = 7)" +
            " and (langObjAttr.value in :langList) and (langObjAttr.attribute.attrId = 8)" +
            " and (formatObjAttr.value in :formatList) and (formatObjAttr.attribute.attrId = 9)")
    public int countFilteredObjects(@Param("objId")int objId, @Param("parentId")String parentId,
                                         @Param("difList")List<String> difficulties,
                                         @Param("langList")List<String> languages,
                                         @Param("formatList")List<String> formats);

    @Query("select obj from Obj obj join obj.objAttrs objAttr where (obj.objectType.objTypesId = :objId) " +
            "and (objAttr.attribute.attrId = 6) ORDER BY  objAttr.value desc ")
    public List<Obj> findAllByObjectTypeOrderedByAttrValue(@Param("objId")int objTypeId, Pageable pageable);

    public int countAllByObjectType_ObjTypesId(@Param("objId")int objTypeId);

    @Query("select distinct obj from Obj obj join obj.objAttrs objAttr where (obj.objectType.objTypesId = :objId) " +
            "and ((objAttr.attribute.attrId = 1) or (objAttr.attribute.attrId = 2)) " +
            "and (lower(objAttr.value) like lower(CONCAT('%',:search,'%')))")
    public List<Obj> searchObj(@Param("search")String search, @Param("objId")int objTypeId, Pageable pageable);

    @Query("select count(distinct obj) from Obj obj join obj.objAttrs objAttr where (obj.objectType.objTypesId = :objId) " +
            "and ((objAttr.attribute.attrId = 1) or (objAttr.attribute.attrId = 2)) " +
            "and (lower(objAttr.value) like lower(CONCAT('%',:search,'%')))")
    public int countSearchObj(@Param("search")String search, @Param("objId")int objTypeId);

}
