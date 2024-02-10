package com.example.clothingBin.src.domain.bin;

import com.example.clothingBin.src.domain.BaseEntity;
import com.querydsl.core.annotations.QueryProjection;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.*;

@Getter
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "ClothingBins")
@AllArgsConstructor
public class Bin {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "clothingBinId")
    private Long clothingBinId;

    private String binName;
    private String location;
    private float latitude; // 위도
    private float longitude; // 경도

    protected Bin() {

    }
    public void setBinCoordinate(Float[] coordinate) {
        this.latitude = coordinate[0];
        this.longitude = coordinate[1];
    }
}
