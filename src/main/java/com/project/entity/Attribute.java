package com.project.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.List;

@Entity
@Table (name = "attributes")
@Setter
@Getter
public class Attribute {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column (name = "attr_id")
    private int attrId;

    @Column (name = "attr_name")
    private String attrName;
    @Column (name = "attr_type")
    private String attrType;
    @Column (name = "is_multiple")
    private boolean isMultiple;
    @Column (name = "is_hidden")
    private boolean isHidden;

    @ManyToMany(fetch=FetchType.EAGER, mappedBy = "objTypeAttributes")
    @JsonBackReference
    private List<ObjectType> objTypes;

    @OneToMany(mappedBy = "attribute")
    @JsonIgnore
    List<ObjAttr> objAttrs;

    @Override
    public String toString() {
        return "Attribute{" +
                "attrId=" + attrId +
                ", attrName='" + attrName + '\'' +
                ", attrType='" + attrType + '\'' +
                ", isMultiple=" + isMultiple +
                ", isHidden=" + isHidden +
                '}';
    }
}
