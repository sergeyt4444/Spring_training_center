package com.project.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "obj_attr")
@Getter
@Setter
public class ObjAttr {

    @EmbeddedId
    ObjAttrKey id;

    @ManyToOne
    @MapsId("objId")
    @JoinColumn(name = "obj_id")
    @JsonIgnore
    Obj object;

    @ManyToOne
    @MapsId("attrId")
    @JoinColumn(name = "attr_id")
    @JsonIgnore
    Attribute attribute;

    private String value;

    @Override
    public String toString() {
        return "ObjAttr{" +
                "id=" + id +
                ", value='" + value + '\'' +
                '}';
    }
}