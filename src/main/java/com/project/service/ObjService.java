package com.project.service;

import com.project.entity.*;
import com.project.repository.AttributeRepository;
import com.project.repository.ObjAttrRepository;
import com.project.repository.ObjRepository;
import com.project.repository.ObjectTypeRepository;
import com.project.tools.ObjectConverter;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class ObjService {

    @Autowired
    private ObjRepository objRepository;

    @Autowired
    private ObjectTypeRepository objectTypeRepository;

    @Autowired
    private AttributeRepository attributeRepository;

    @Autowired
    private ObjAttrRepository objAttrRepository;

    public List<Obj> findByObjTypeId(int objType) {
        return objRepository.findAllByObjectType_ObjTypesId(objType);
    }

    public List<Obj> findByObjTypeId(ObjectTypeEnum objectTypeEnum) {
        return objRepository.findAllByObjectType_ObjTypesId(objectTypeEnum.getValue());
    }

    public List<Obj> findByObjTypeAndParentId(int objType, String parentId, int pageNum, int pageSize) {
        parentId = validateParentId(parentId);
        Pageable pageable = PageRequest.of(pageNum - 1, pageSize);
        return objRepository.findAllByObjectTypeAndParentId(objType, parentId, pageable);
    }

    public int countByObjTypeAndParentId(int objType, String parentId) {
        parentId = validateParentId(parentId);
        return objRepository.countAllByObjectTypeAndParentId(objType, parentId);
    }

    public Obj findByObjTypeAndName(int objType, String name) {
        name = validateName(name);
        List<Obj> list = objRepository.findByObjectTypeAndName(objType, name);
        if (list.isEmpty()) {
            return null;
        }
        else {
            return list.get(0);
        }
    }

    public Obj findByObjTypeAndName(ObjectTypeEnum objectTypeEnum, String name) {
        name = validateName(name);
        List<Obj> list = objRepository.findByObjectTypeAndName(objectTypeEnum.getValue(), name);
        if (list.isEmpty()) {
            return null;
        }
        else {
            return list.get(0);
        }
    }

    public Obj findByObjTypeAndUsername(int objType, String username) {
        username = validateName(username);
        return objRepository.findByObjectTypeAndUsername(objType, username).get(0);
    }

    public Obj findByObjTypeAndUsername(ObjectTypeEnum objectTypeEnum, String username) {
        username = validateName(username);
        return objRepository.findByObjectTypeAndUsername(objectTypeEnum.getValue(), username).get(0);
    }

    public List<Obj> findByObjTypeAndParentId(ObjectTypeEnum objectTypeEnum, String parentId) {
        parentId = validateParentId(parentId);
        return objRepository.findAllByObjectTypeAndParentId(objectTypeEnum.getValue(), parentId);
    }

    public List<Obj> findByObjTypeAndParentId(ObjectTypeEnum objectTypeEnum, String parentId, int pageNum, int pageSize) {
        parentId = validateParentId(parentId);
        Pageable pageable = PageRequest.of(pageNum - 1, pageSize);
        return objRepository.findAllByObjectTypeAndParentId(objectTypeEnum.getValue(), parentId, pageable);
    }

    public Optional<Obj> findById(int id) {
        return objRepository.findById(id);
    }

    public void createObj(Map<Integer, String> mappedObj, int objTypeId) {
        Obj obj = new Obj();
        obj.setObjectType(objectTypeRepository.getById(objTypeId));
        List<ObjAttr> objAttrList = new ArrayList<>();
        for (Map.Entry<Integer, String> entry: mappedObj.entrySet())
        {
            Attribute attr = attributeRepository.getById(entry.getKey());
            ObjAttr objAttr = new ObjAttr();
            objAttr.setAttribute(attr);
            objAttr.setValue(entry.getValue());
            objAttrList.add(objAttr);
        }
        obj.setObjAttrs(objAttrList);
        objRepository.save(obj);
    }

    public List<Obj> findFilteredObjects(int objId, String parentId, List<String> difficulties,
                                         List<String> languages, List<String> formats, int pageNum, int pageSize) {
        Pageable pageable = PageRequest.of(pageNum - 1, pageSize);
        return objRepository.findFilteredObjects(objId, parentId, difficulties, languages, formats, pageable);
    }

    public int countFilteredObjects(int objId, String parentId, List<String> difficulties,
                                         List<String> languages, List<String> formats) {
        return objRepository.countFilteredObjects(objId, parentId, difficulties, languages, formats);
    }

    public List<Obj> findCoursesPaged(Integer pageNum, Integer pageSize) {
        Pageable pageable = PageRequest.of(pageNum - 1, pageSize);
        List<Obj> results = objRepository.findAllByObjectTypeOrderedByAttrValue(2, pageable);
        return results;
    }

    public int getCoursesCount() {
        return objRepository.countAllByObjectType_ObjTypesId(ObjectTypeEnum.COURSE.getValue());
    }

    public int getMainCategoriesCount() {
        return objRepository.countMainCategories();
    }

    public List<Map<Integer, String>> searchObj(String searchQuery, int objTypeId, Integer pageNum, Integer pageSize) {
        String preparedQuery = prepareSearchQuery(searchQuery);
        List<Integer> resultIds = objRepository.searchObjIds(preparedQuery, objTypeId);
        List<Obj> results = objRepository.findAllByObjIdIn(resultIds);
        List<Map<Integer, String>> mappedResults = ObjectConverter.convertListOfObjects(results);
        return mappedResults.stream().filter(obj -> (countQueryWords(obj, searchQuery) >= (StringUtils.countMatches(preparedQuery, "|")/2)))
                .sorted(new Comparator<Map<Integer, String>>() {
            @Override
            public int compare(Map<Integer, String> o1, Map<Integer, String> o2) {
                return countQueryWords(o2, searchQuery) - countQueryWords(o1, searchQuery);
            }
        }).skip((pageNum-1)*pageSize).limit(pageSize).collect(Collectors.toList());
    }

    public int countSearchObj(String searchQuery, int objTypeId) {
        return objRepository.countSearchObj(prepareSearchQuery(searchQuery), ObjectTypeEnum.COURSE.getValue());
    }

    private String validateParentId(String parentId) {
        if (parentId == null) {
            return  "0";
        }
        return parentId;
    }

    private String validateName(String name) {
        if (name == null) {
            return "";
        }
        return name;
    }

    private String prepareSearchQuery(String searchQuery) {
        searchQuery = searchQuery.replaceAll("\\pP", "");
        List<String> queryWords = Arrays.asList(searchQuery.split(" "));
        StringBuilder queryString = new StringBuilder("(");
        if (!queryWords.isEmpty()) {
            queryString.append("%").append(queryWords.get(0)).append("%");
            for (int i = 1; i < queryWords.size(); i++) {
                queryString.append("|").append("%").append(queryWords.get(i)).append("%");
            }
        }
        queryString.append(")");
        return queryString.toString();
    }

    private int countQueryWords(Map<Integer, String> obj, String searchQuery) {
        List<String> queryWords = Arrays.asList(searchQuery.split(" "));
        int count = 0;
        for (String queryWord: queryWords) {
            count += StringUtils.countMatches(obj.get(AttrEnum.COURSE_NAME.getValue()), queryWord);
            count += StringUtils.countMatches(obj.get(AttrEnum.COURSE_DESCRIPTION.getValue()), queryWord);
        }
        return count;
    }

}
