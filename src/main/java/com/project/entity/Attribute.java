package com.project.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table (name = "attributes")
@Setter
@Getter
public class Attribute {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int attr_id;

    private String attr_name;
    private String attr_type;
    private boolean is_multiple;
    private boolean is_hidden;

    @ManyToMany(fetch=FetchType.EAGER, mappedBy = "objTypeAttributes")
    @JsonBackReference
    private List<ObjectType> objTypes;

    @OneToMany(mappedBy = "attribute")
    @JsonIgnore
    List<ObjAttr> objAttrs;

    @Override
    public String toString() {
        return "Attribute{" +
                "attr_id=" + attr_id +
                ", attr_name='" + attr_name + '\'' +
                ", attr_type='" + attr_type + '\'' +
                ", is_multiple=" + is_multiple +
                ", is_hidden=" + is_hidden +
                '}';
    }
}
