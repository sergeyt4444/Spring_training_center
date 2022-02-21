package com.project.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "obj_attr")
@Getter
@Setter
public class ObjAttr {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column (name = "obj_attr_id")
    private int objAttrId;

    @Column(name = "obj_id")
    private int objId;

    @ManyToOne(cascade=CascadeType.PERSIST)
    @JoinColumn(name = "attr_id")
    private Attribute attribute;

    private String value;

    @Override
    public String toString() {
        return "ObjAttr{" +
                "objAttrId=" + objAttrId +
                ", objId=" + objId +
                ", attribute=" + attribute +
                ", value='" + value + '\'' +
                '}';
    }
}
