package com.example.clothingBin.src.domain.user;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.*;

@Getter
@Entity
@DynamicInsert
@DynamicUpdate
@AllArgsConstructor
@Table(name = "Certifications")
public class Certification {
    @Id
    @Column(name = "phoneNum")
    private String phoneNum;
    private int certificationNum;

    protected Certification() {

    }
}
