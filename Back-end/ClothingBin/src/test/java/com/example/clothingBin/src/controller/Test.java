package com.example.clothingBin.src.controller;

import com.example.clothingBin.config.BaseException;
import com.google.code.geocoder.Geocoder;
import com.google.code.geocoder.GeocoderRequestBuilder;
import com.google.code.geocoder.model.*;

import static com.example.clothingBin.config.BaseResponseStatus.GEO_FAIL;
import static com.example.clothingBin.config.BaseResponseStatus.LOCATION_NULL;

public class Test {
    public static void main(String[] args) throws BaseException {
        String location = "경기도 성남시 분당구";

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
//            return coords;
                System.out.println(coords);
//            } else {
//                System.out.println("rlahfls");
//            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new BaseException(GEO_FAIL);
        }
    }
}
