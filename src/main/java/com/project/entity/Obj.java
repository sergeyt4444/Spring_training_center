package com.project.entity;


import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.List;

@Entity
@Table (name = "object")
@Getter
@Setter
public class Obj {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column (name = "obj_id")
    private int objId;


    @OneToMany(mappedBy = "object", fetch=FetchType.EAGER)
    @JsonIgnore
    private List<ObjAttr> objAttrs;

    @ManyToOne(fetch=FetchType.EAGER)
    @JoinColumn(name="obj_type_id")
    private ObjectType objectType;

    @Override
    public String toString() {
        return "Obj{" +
                "obj_id=" + objId +
                ", objectType=" + objectType +
                '}';
    }
}
