package com.project.entity;


import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

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

    @OneToMany(fetch=FetchType.EAGER, cascade=CascadeType.ALL)
    @JoinColumn(name = "obj_id", referencedColumnName = "obj_id")
    @Fetch(value = FetchMode.SUBSELECT)
    private List<ObjAttr> objAttrs;

    @ManyToOne(fetch=FetchType.EAGER)
    @JoinColumn(name="obj_type_id")
    private ObjectType objectType;

    @Override
    public String toString() {
        return "Obj{" +
                "objId=" + objId +
                ", objAttrs=" + objAttrs +
                ", objectType=" + objectType +
                '}';
    }
}
