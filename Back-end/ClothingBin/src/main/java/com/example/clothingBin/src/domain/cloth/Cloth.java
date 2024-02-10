package com.example.clothingBin.src.domain.cloth;

import com.example.clothingBin.src.domain.BaseEntity;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.springframework.data.annotation.CreatedDate;

import javax.persistence.*;
import java.sql.Timestamp;
import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "Clothes")
public class Cloth extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "clothId")
    private Long clothId;
    private Long userId;
    private Long clothingBinId;
    private String clothName;
    private String price;
    private String description;
    private String category;
    private String imgLink;
    private boolean collected;
    private short lockerNum;

//    @CreatedDate
//    @Column(name = "insertDate", updatable = false)
//    private LocalDateTime insertDateTime;
}
