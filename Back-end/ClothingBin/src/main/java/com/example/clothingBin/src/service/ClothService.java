package com.example.clothingBin.src.service;

import com.example.clothingBin.config.BaseException;
import com.example.clothingBin.src.dao.cloth.ClothRepository;
import com.example.clothingBin.src.dao.cloth.ClothingBinBasketRepository;
import com.example.clothingBin.src.domain.cloth.Cloth;
import com.example.clothingBin.src.domain.cloth.ClothingBinBasket;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.print.attribute.standard.DateTimeAtCompleted;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import static com.example.clothingBin.config.BaseResponseStatus.*;

@Service
@RequiredArgsConstructor
public class ClothService {

    private final ClothingBinBasketRepository clothingBinBasketRepository;
    private final ClothRepository clothRepository;

    public List<Cloth> getAllClothes(Long clothingBinId) throws BaseException {
//        boolean nonExistCloth;
//        try {
//            nonExistCloth = !clothRepository.existsByClothingBinId(clothingBinId);
//        } catch (Exception e) {
//            throw new BaseException(DATABASE_ERROR);
//        }
//
//        if (nonExistCloth) {
//            throw new BaseException(CLOTH_NULL);
//        }
//
//        try {
//            return clothRepository.findAllByClothingBinId(clothingBinId);
//        } catch (Exception e) {
//            throw new BaseException(DATABASE_ERROR);
//        }
        ////////////////////
        try {
            if (!clothRepository.existsByClothingBinId(clothingBinId)) {
                throw new BaseException(CLOTH_NULL);
            }
            return clothRepository.findAllByClothingBinId(clothingBinId);
        } catch (BaseException e) {
            throw e;
        } catch (Exception e) {
            throw new BaseException(DATABASE_ERROR);
        }
    }

    public Cloth getCloth(Long clothId) throws BaseException {
//        boolean nonExistCloth;
//        try {
//            nonExistCloth = !clothRepository.existsById(clothId);
//        } catch (Exception e) {
//            throw new BaseException(DATABASE_ERROR);
//        }
//
//        if (nonExistCloth) {
//            throw new BaseException(CLOTH_NULL);
//        }
//
//        try {
//            return clothRepository.findById(clothId).orElse(null);
//        } catch (Exception e) {
//            throw new BaseException(DATABASE_ERROR);
//        }
////////////////////
        try {
            if (!clothRepository.existsById(clothId)) {
                throw new BaseException(CLOTH_NULL);
            }
            return clothRepository.findById(clothId).orElse(null);
        } catch (BaseException e) {
            throw e;
        } catch (Exception e) {
            throw new BaseException(DATABASE_ERROR);
        }
    }

    public void inputCloth(Cloth postClothReq) throws BaseException {
        try {
            clothRepository.save(postClothReq);
        } catch (Exception e) {
            throw new BaseException(DATABASE_ERROR);
        }
    }

    public void throwCloth(ClothingBinBasket postThrowClothReq) throws BaseException {
        try {
//            postThrowClothReq.setInputTime(Timestamp.valueOf(LocalDateTime.now()));
            clothingBinBasketRepository.save(postThrowClothReq);
        } catch (Exception exception) {
            throw new BaseException(DATABASE_ERROR);
        }
    }

    public void deleteCloth(Long clothId) throws BaseException {
        try {
            clothRepository.deleteById(clothId);
        } catch (Exception exception) {
            throw new BaseException(DATABASE_ERROR);
        }
    }
}