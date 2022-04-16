package com.project.events;

import lombok.Getter;
import org.springframework.context.ApplicationEvent;

import java.util.Map;

@Getter
public class FullCapacityEvent extends ApplicationEvent {

    private Map<Integer, String> mappedCourse;

    public FullCapacityEvent(Object source, Map<Integer, String> mappedCourse) {
        super(source);
        this.mappedCourse = mappedCourse;
    }

}
