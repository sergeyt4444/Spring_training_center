package com.project.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

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
