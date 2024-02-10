package com.example.clothingBin.src.service;

import com.example.clothingBin.src.dao.bin.BinRepository;
import com.example.clothingBin.src.domain.bin.Bin;
import com.example.clothingBin.config.BaseException;

import com.google.code.geocoder.*;
import com.google.code.geocoder.model.*;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import static com.example.clothingBin.config.BaseResponseStatus.*;


@Service
@RequiredArgsConstructor
public class BinService {
    private final BinRepository binRepository;
    private final EntityManager entityManager;

    public List<Bin> getAllAddresses() throws BaseException {
        try {
//            List<Bin> binList = binRepository.findAll();
//            return binList.stream()
//                    .map(bin -> new BinDto(bin))
//                    .collect(Collectors.toList());
            return binRepository.findAll();

        } catch (Exception exception) {
            throw new BaseException(DATABASE_ERROR);
        }
    }

    // 주소 입력하면 위경도 입력해줌.
    public Float[] findGeoPoint(String location) throws BaseException {

        if (location == null)
            throw new BaseException(LOCATION_NULL);

        // setAddress : 변환하려는 주소 (경기도 성남시 분당구 등)
        // setLanguage : 인코딩 설정
        GeocoderRequest geocoderRequest = new GeocoderRequestBuilder().setAddress(location).setLanguage("ko").getGeocoderRequest();

        try {
            Geocoder geocoder = new Geocoder();
            GeocodeResponse geocoderResponse = geocoder.geocode(geocoderRequest);

//            if (geocoderResponse.getStatus() == GeocoderStatus.OK && !geocoderResponse.getResults().isEmpty()) {
            GeocoderResult geocoderResult = geocoderResponse.getResults().iterator().next();
            LatLng latitudeLongitude = geocoderResult.getGeometry().getLocation();

            Float[] coords = new Float[2];
            coords[0] = latitudeLongitude.getLat().floatValue(); // 위도
            coords[1] = latitudeLongitude.getLng().floatValue(); // 경도
            return coords;
//            } else {
//                System.out.println("rlahfls");
//            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new BaseException(GEO_FAIL);
        }
//        throw new BaseException(GEO_FAIL);
//        return null;
    }

    public void addBin(Bin bin) throws BaseException {
        try {
            binRepository.save(bin);
        } catch (Exception e) {
            throw new BaseException(DATABASE_ERROR);
        }
    }

    public List<Bin> test() {
        return binRepository.findByBinNameAndLatitude("1", 1);
    }
}
