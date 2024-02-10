package com.example.clothingBin.src.controller;

import com.example.clothingBin.config.BaseException;
import com.example.clothingBin.config.BaseResponse;
import com.example.clothingBin.src.domain.cloth.Cloth;
import com.example.clothingBin.src.domain.cloth.ClothingBinBasket;
import com.example.clothingBin.src.service.ClothService;
import com.example.clothingBin.utils.JwtService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequestMapping("/app/cloth")
@AllArgsConstructor
public class ClothController {
    private final JwtService jwtService;
    private final ClothService clothService;

    @GetMapping("")
    public BaseResponse<List<Cloth>> getAllClothes(@RequestParam Long clothingBinId) {
        try {
            return new BaseResponse<>(clothService.getAllClothes(clothingBinId));
        } catch (BaseException exception) {
            return new BaseResponse<>(exception.getStatus());
        }
    }
// shift + f6
    @GetMapping("/get")
    public BaseResponse<Cloth> getCloth(@RequestParam Long clothId) {
        try {
            return new BaseResponse<>(clothService.getCloth(clothId));
        } catch (BaseException exception) {
            return new BaseResponse<>(exception.getStatus());
        }
    }

    @PostMapping("/throw")
    public BaseResponse<String> throwCloth(@RequestBody ClothingBinBasket postThrowClothReq) {
        try{
            postThrowClothReq.setUserId(jwtService.getUserId());
            clothService.throwCloth(postThrowClothReq);
            return new BaseResponse<>("의류 투입 성공");
        } catch (BaseException exception) {
            return new BaseResponse<>(exception.getStatus());
        }
    }
    @PostMapping("/input")
    public BaseResponse<String> inputCloth(@RequestBody Cloth postClothReq) {
        try {
            postClothReq.setUserId(jwtService.getUserId());
            clothService.inputCloth(postClothReq);
            return new BaseResponse<>("의류 판매 등록 성공");
        } catch (BaseException exception) {
            return new BaseResponse<>(exception.getStatus());
        }
    }

    @DeleteMapping("")
    public BaseResponse<String> deleteCloth(@RequestParam Long clothId) {
        try {
            clothService.deleteCloth(clothId);
            return new BaseResponse<>("의류 삭제 완료");
        } catch (BaseException exception) {
            return new BaseResponse<>(exception.getStatus());
        }
    }
}
