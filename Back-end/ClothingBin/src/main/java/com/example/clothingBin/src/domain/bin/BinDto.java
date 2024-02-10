package com.example.clothingBin.src.domain.bin;

import com.querydsl.core.annotations.QueryProjection;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

@Data
@Setter
@RequiredArgsConstructor
public class BinDto {
//    private Long clothingBinId;
    private String binName;
    private String location;
    private Float latitude; // 위도
    private Float longitude; // 경도

//    @QueryProjection
//    public BinDto(Bin bin) {
//        this.clothingBinId = bin.getClothingBinId();
//        this.binName = bin.getBinName();
//        this.location = bin.getLocation();
//    }
}
