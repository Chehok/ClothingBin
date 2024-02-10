package com.example.clothingBin.src.controller;

import java.util.ArrayList;
import java.util.List;

import com.example.clothingBin.config.BaseResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;

@RestController
@RequestMapping("/app/files")
@RequiredArgsConstructor
public class FileController {

    private String S3Bucket = "clothing-bin-bucket"; // Bucket 이름

    @Autowired
    AmazonS3Client amazonS3Client;

    @PostMapping("/upload")
    public BaseResponse<String> upload(MultipartFile image) throws Exception {

        String originalName = image.getOriginalFilename(); // 파일 이름
        long size = image.getSize(); // 파일 크기

        ObjectMetadata objectMetaData = new ObjectMetadata();
        objectMetaData.setContentType(image.getContentType());
        objectMetaData.setContentLength(size);

        // S3에 업로드
        amazonS3Client.putObject(
                new PutObjectRequest(S3Bucket, originalName, image.getInputStream(), objectMetaData)
                        .withCannedAcl(CannedAccessControlList.PublicRead)
        );

        String imagePath = amazonS3Client.getUrl(S3Bucket, originalName).toString(); // 접근가능한 URL 가져오기
//        return new ResponseEntity<String>(imagePath, HttpStatus.OK);
        return new BaseResponse<>(imagePath);
    }
}

