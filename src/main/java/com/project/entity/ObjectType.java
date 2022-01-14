package com.project.entity;

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
    @Column (name = "obj_types_id")
    private int objTypesId;

    @Column (name = "obj_types_name")
    private String objTypesName;

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
                "obj_types_id=" + objTypesId +
                ", obj_types_name='" + objTypesName + '\'' +
                ", objTypeAttributes=" + objTypeAttributes +
                '}';
    }
}
