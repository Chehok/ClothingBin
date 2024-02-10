package com.example.clothingBin.src.domain.cloth;

import com.example.clothingBin.src.domain.BaseEntity;
import com.sun.istack.NotNull;
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
@Table(name = "ClothingBinBaskets")
public class ClothingBinBasket extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "basketId")
    private Long basketId;

    @NotNull
    private Long userId;
    @NotNull
    private Long clothingBinId;

//    @CreatedDate
//    @Column(name = "inputDate", updatable = false)
//    private LocalDateTime inputDateTime;
}
