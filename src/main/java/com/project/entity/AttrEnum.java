package com.project.entity;

public enum AttrEnum {
    COURSE_NAME(1), COURSE_DESCRIPTION(2), PARENT_ID(3), TEST_ATTRIBUTE(4), CREATOR(5),
    START_DATE(6), DIFFICULTY(7), LANGUAGE(8), FORMAT(9), PARTICIPANTS_REQUIRED(10),
    CURRENT_PARTICIPANTS(11), SUBSCRIBERS(12), REQUIREMENTS(13), USER_NAME(500),
    USER_COURSES(501), COURSES_NOTIFIED(502), COURSES_FINISHED(503), COURSES_FAILED(504);

    private final int attrId;

    private AttrEnum(int attrId) {
        this.attrId = attrId;
    }

    public int getValue() {
        return attrId;
    }
}
