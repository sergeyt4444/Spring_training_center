package com.project.entity;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;

@Embeddable
@Data
public class ObjAttrKey implements Serializable {

    @Column(name = "obj_id")
    private int objId;

    @Column(name = "attr_id")
    private int attrId;



}
