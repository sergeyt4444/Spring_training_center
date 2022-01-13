package com.project.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.List;

@Entity
@Table (name = "obj_types")
@Getter
@Setter
public class ObjectType {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int obj_types_id;

    private String obj_types_name;

    @ManyToMany(fetch=FetchType.EAGER)
    @JoinTable(
            name = "obj_type_attr",
            joinColumns = @JoinColumn(name = "obj_type_id"),
            inverseJoinColumns = @JoinColumn(name = "attr_id")
    )
    @JsonManagedReference
    private List<Attribute> objTypeAttributes;

    @Override
    public String toString() {
        return "ObjectType{" +
                "obj_types_id=" + obj_types_id +
                ", obj_types_name='" + obj_types_name + '\'' +
                ", objTypeAttributes=" + objTypeAttributes +
                '}';
    }
}
