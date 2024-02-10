package com.example.clothingBin.src.controller;

import com.example.clothingBin.config.BaseException;
import com.example.clothingBin.config.BaseResponse;
import com.example.clothingBin.src.domain.bin.Bin;
import com.example.clothingBin.src.service.BinService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/app/bins")
@RequiredArgsConstructor
public class BinController {
    private final BinService binService;

    // 전체 의류수거함 주소, 위경도 가져오기
    @GetMapping("/address")
    public BaseResponse<List<Bin>> getAllAddress() {
        try {
            return new BaseResponse<>(binService.getAllAddresses());
        } catch (BaseException exception) {
            return new BaseResponse<>(exception.getStatus());
        }
    }

    // 의류수거함 추가
    @PostMapping("/address")
    public BaseResponse<String> addBin(@RequestBody Bin bin) {
        try {
            System.out.println(bin.getLocation());
            bin.setBinCoordinate(binService.findGeoPoint(bin.getLocation()));
            binService.addBin(bin);

            return new BaseResponse<>("새 의류수거함 등록 완료");
        } catch (BaseException exception) {
            return new BaseResponse<>(exception.getStatus());
        }
    }
    @PatchMapping("/test")
    public BaseResponse<List<Bin>> test() {
        return new BaseResponse<>(binService.test());
    }

//    // 의류수거함 정보 수정
//    @PatchMapping("/address")
}