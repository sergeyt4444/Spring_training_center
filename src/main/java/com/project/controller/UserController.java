package com.project.controller;

import com.project.entity.*;
import com.project.misc.MiscTool;
import com.project.service.*;
import com.project.tools.ObjectConverter;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.xml.ws.http.HTTPException;
import java.util.*;

@RestController
@RequestMapping("/user")
@PreAuthorize("hasRole('USER')")
public class UserController {

    @Autowired
    private ObjService objService;

    @Autowired
    private ObjAttrService objAttrService;

    @Autowired
    private MailService mailService;

    @GetMapping("/main_categories")
    public ResponseEntity<List<Obj>> getMainCategories(@RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer pageSize) {
        return ResponseEntity.ok(objService.findByObjTypeAndParentId(ObjectTypeEnum.CATEGORY, "0", page,pageSize));
    }

    @GetMapping("/main_categories_count")
    public ResponseEntity<Integer> getMainCategoriesCount() {
        return ResponseEntity.ok(objService.getMainCategoriesCount());
    }

    @GetMapping("/users")
    public ResponseEntity<List<Obj>> getUsers() {
        return ResponseEntity.ok(objService.findByObjTypeId(ObjectTypeEnum.USER));
    }

    @GetMapping("category/{name}")
    public ResponseEntity<Obj> getCategoryByName(@PathVariable(value = "name")String name) {
        return ResponseEntity.ok(objService.findByObjTypeAndName(ObjectTypeEnum.CATEGORY, name));
    }

    @GetMapping("categories/{pid}")
    public ResponseEntity<List<Obj>> getSubCategories(@PathVariable(value = "pid")Integer parentId) {
        return ResponseEntity.ok(objService.findByObjTypeAndParentId(ObjectTypeEnum.CATEGORY, parentId.toString()));
    }

    @GetMapping("object_by_id/{id}")
    public ResponseEntity<Obj> getObjectById(@PathVariable(value = "id")Integer id) {
        try {
            Obj obj = objService.findById(id).orElseThrow(
                    () -> new HTTPException(404)
            );
            return ResponseEntity.ok(obj);
        }
        catch (HTTPException e) {
            return new ResponseEntity<Obj>(
                    null, new HttpHeaders(), HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping("courses/{pid}")
    public ResponseEntity<List<Obj>> getCourses(@PathVariable(value = "pid")Integer parentId,
                                                @RequestParam(defaultValue = "1") Integer page,
                                                @RequestParam(defaultValue = "10") Integer pageSize) {
        return ResponseEntity.ok(objService.findByObjTypeAndParentId(ObjectTypeEnum.COURSE, parentId.toString(),
                                 page, pageSize));
    }

    @GetMapping("filteredcourses/{pid}")
    public ResponseEntity<List<Obj>> getFilteredCourses(@PathVariable(value = "pid")Integer parentId,
                                                        @RequestParam List<String> difficulties,
                                                        @RequestParam List<String> languages,
                                                        @RequestParam List<String> formats,
                                                        @RequestParam(defaultValue = "1") Integer page,
                                                        @RequestParam(defaultValue = "10") Integer pageSize) {
        return ResponseEntity.ok(objService.findFilteredObjects(ObjectTypeEnum.COURSE.getValue(), parentId.toString(),
                difficulties, languages, formats, page, pageSize));
    }

    @GetMapping("courses_count/{pid}")
    public ResponseEntity<Integer> getCoursesCount(@PathVariable(value = "pid")Integer parentId) {
        return ResponseEntity.ok(objService.countByObjTypeAndParentId(ObjectTypeEnum.COURSE.getValue(), parentId.toString()));
    }

    @GetMapping("filteredcourses_count/{pid}")
    public ResponseEntity<Integer> getFilteredCoursesCount(@PathVariable(value = "pid")Integer parentId,
                                                        @RequestParam List<String> difficulties,
                                                        @RequestParam List<String> languages,
                                                        @RequestParam List<String> formats) {
        return ResponseEntity.ok(objService.countFilteredObjects(ObjectTypeEnum.COURSE.getValue(), parentId.toString(),
                difficulties, languages, formats));
    }

    @PutMapping("/usercourses")
    public ResponseEntity addUserCourse(@RequestBody Map<String, String> mappedObjAttr) {
        if (MiscTool.accesibleByUsersAttrs.contains(mappedObjAttr.get("name"))) {
            Obj obj = objService.findById(Integer.parseInt(mappedObjAttr.get("objId"))).orElse(new Obj());
            objAttrService.changeObjAttr(mappedObjAttr, obj);
            return new ResponseEntity(HttpStatus.NO_CONTENT);
        }
        else {
            return new ResponseEntity(HttpStatus.FORBIDDEN);
        }
    }

    @PutMapping("/usercourses_bulk")
    public ResponseEntity addUserCourseBulk(@RequestBody List<Map<String, String>> mappedObjAttrList) {
        for (Map<String,String> mappedObjAttr: mappedObjAttrList) {
            addUserCourse(mappedObjAttr);
        }
        return new ResponseEntity(HttpStatus.NO_CONTENT);
    }

    @GetMapping("users/{name}")
    public ResponseEntity getUser(@PathVariable (value = "name") String username) {
        return ResponseEntity.ok(objService.findByObjTypeAndUsername(ObjectTypeEnum.USER.getValue(), username));
    }

    @GetMapping("usercourses/{name}")
    public ResponseEntity<List<Obj>> getUserCourses(@PathVariable (value = "name") String username,
                                                    @RequestParam(defaultValue = "1") Integer page,
                                                    @RequestParam(defaultValue = "10") Integer pageSize) {
        Obj user = objService.findByObjTypeAndUsername(ObjectTypeEnum.USER.getValue(), username);
        Map<Integer, String> mappedUser = ObjectConverter.convertObject(user);
        List<String> coursesIds = Arrays.asList(mappedUser.get(AttrEnum.USER_COURSES.getValue()).split(";"));
        List<Obj> courses = new ArrayList<>();
        for (int i = (page-1)*pageSize; i < page*pageSize && i < coursesIds.size(); i++) {
            if (coursesIds.get(i).matches("\\d+")) {
                courses.add(objService.findById(Integer.parseInt(coursesIds.get(i))).orElseThrow(() -> new HTTPException(404)));
            }
        }
        return ResponseEntity.ok(courses);
    }

    @GetMapping("usercourses/{name}/count")
    public ResponseEntity<Integer> getUserCoursesCount(@PathVariable (value = "name") String username) {
        Obj user = objService.findByObjTypeAndUsername(ObjectTypeEnum.USER.getValue(), username);
        Map<Integer, String> mappedUser = ObjectConverter.convertObject(user);
        return ResponseEntity.ok(StringUtils.countMatches(mappedUser.get(AttrEnum.USER_COURSES.getValue()), ";"));
    }

    @GetMapping("passed_usercourses/{name}/count")
    public ResponseEntity<Integer> getPassedUserCoursesCount(@PathVariable (value = "name") String username) {
        Obj user = objService.findByObjTypeAndUsername(ObjectTypeEnum.USER.getValue(), username);
        Map<Integer, String> mappedUser = ObjectConverter.convertObject(user);
        return ResponseEntity.ok(StringUtils.countMatches(mappedUser.get(AttrEnum.COURSES_FINISHED.getValue()), ";"));
    }

    @GetMapping("passed_usercourses/{name}")
    public ResponseEntity<List<Obj>> getPassedUserCourses(@PathVariable (value = "name") String username,
                                                    @RequestParam(defaultValue = "1") Integer page,
                                                    @RequestParam(defaultValue = "10") Integer pageSize) {
        Obj user = objService.findByObjTypeAndUsername(ObjectTypeEnum.USER.getValue(), username);
        Map<Integer, String> mappedUser = ObjectConverter.convertObject(user);
        List<String> coursesIds = Arrays.asList(mappedUser.get(AttrEnum.COURSES_FINISHED.getValue()).split(";"));
        List<Obj> courses = new ArrayList<>();
        for (int i = (page-1)*pageSize; i < page*pageSize && i < coursesIds.size(); i++) {
            if (coursesIds.get(i).matches("\\d+")) {
                courses.add(objService.findById(Integer.parseInt(coursesIds.get(i))).orElseThrow(() -> new HTTPException(404)));
            }
        }
        return ResponseEntity.ok(courses);
    }

    @GetMapping("failed_usercourses/{name}")
    public ResponseEntity<List<Obj>> getFailedUserCourses(@PathVariable (value = "name") String username,
                                                    @RequestParam(defaultValue = "1") Integer page,
                                                    @RequestParam(defaultValue = "10") Integer pageSize) {
        Obj user = objService.findByObjTypeAndUsername(ObjectTypeEnum.USER.getValue(), username);
        Map<Integer, String> mappedUser = ObjectConverter.convertObject(user);
        List<String> coursesIds = Arrays.asList(mappedUser.get(AttrEnum.COURSES_FAILED.getValue()).split(";"));
        List<Obj> courses = new ArrayList<>();
        for (int i = (page-1)*pageSize; i < page*pageSize && i < coursesIds.size(); i++) {
            if (coursesIds.get(i).matches("\\d+")) {
                courses.add(objService.findById(Integer.parseInt(coursesIds.get(i))).orElseThrow(() -> new HTTPException(404)));
            }
        }
        return ResponseEntity.ok(courses);
    }

    @GetMapping("failed_usercourses/{name}/count")
    public ResponseEntity<Integer> getFailedUserCoursesCount(@PathVariable (value = "name") String username) {
        Obj user = objService.findByObjTypeAndUsername(ObjectTypeEnum.USER.getValue(), username);
        Map<Integer, String> mappedUser = ObjectConverter.convertObject(user);
        return ResponseEntity.ok(StringUtils.countMatches(mappedUser.get(AttrEnum.COURSES_FAILED.getValue()), ";"));
    }

    @GetMapping("latest_courses")
    public ResponseEntity<List<Obj>> getLatestCourses(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer pageSize) {
        List<Obj> result = objService.findCoursesPaged(page, pageSize);
        return ResponseEntity.ok(result);
    }

    @GetMapping("courses_count")
    public ResponseEntity<Integer> getCoursesCount() {
        return ResponseEntity.ok(objService.getCoursesCount());
    }

    @GetMapping("search")
    public ResponseEntity<List<Map<Integer, String>>> searchCourses(@RequestParam String searchQuery,
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer pageSize) {
        List<Map<Integer, String>> result = objService.searchObj(searchQuery, ObjectTypeEnum.COURSE.getValue(), page, pageSize);
        return ResponseEntity.ok(result);
    }

    @GetMapping("search_count")
    public ResponseEntity<Integer> countSearchCourses(@RequestParam String searchQuery) {
        return ResponseEntity.ok(objService.countSearchObj(searchQuery, ObjectTypeEnum.COURSE.getValue()));
    }

    @GetMapping("categories")
    public ResponseEntity<List<Obj>> getCategories() {
        return ResponseEntity.ok(objService.findByObjTypeId(ObjectTypeEnum.CATEGORY));
    }

    @PostMapping("register")
    public ResponseEntity registerUser(@RequestBody Map<Integer, String> mappedObj) {
        objService.createObj(mappedObj, ObjectTypeEnum.USER.getValue());
        return new ResponseEntity(HttpStatus.NO_CONTENT);
    }

    @PostMapping("mail")
    public ResponseEntity sendMailNotifications(@RequestBody Integer courseId) {
        mailService.sendMailNotifications(courseId);
        return new ResponseEntity(HttpStatus.NO_CONTENT);
    }

    @GetMapping("all_courses")
    public  ResponseEntity<List<Obj>> getAllCourses() {
        return ResponseEntity.ok(objService.findByObjTypeId(ObjectTypeEnum.COURSE.getValue()));
    }


}
