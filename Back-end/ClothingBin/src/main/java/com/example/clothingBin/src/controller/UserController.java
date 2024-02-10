package com.example.clothingBin.src.controller;

import com.example.clothingBin.config.BaseException;
import com.example.clothingBin.config.BaseResponse;
import com.example.clothingBin.src.domain.user.*;
import com.example.clothingBin.src.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/app/users")
@RequiredArgsConstructor
public class UserController {
    private final UserService userService;

    // 비회원 로직 ===============================================================

    // 인증번호 요청 메서드
    @GetMapping("/phone")
    public BaseResponse<String> phone(@RequestParam String phoneNum) {
        try {
            userService.sendSMS(phoneNum); // sms로 인증번호를 보냄 한달 50번
            return new BaseResponse<>("인증번호 발송 완료");
//            return new BaseResponse<>(userService.testSMS(phoneNum)); // response body로 인증번호를 보냄 테스트용. 무제한.
        } catch (BaseException exception) {
            return new BaseResponse<>(exception.getStatus());
        }
    }

    // 인증번호 검증.
    @PostMapping("/phone")
    public BaseResponse<CertifyMemberDto> certificationSMS(@RequestBody CertificationNumDto certificationNum) {
        try {
            return new BaseResponse<>(userService.certificationSMS(certificationNum));
        } catch (BaseException exception) {
            return new BaseResponse<>(exception.getStatus());
        }
    }

    // 회원 로직 ===============================================================

    // 회원가입
    @PostMapping("/sign-up")
    public BaseResponse<String> signUp(@RequestBody User user) {
        try {
            return new BaseResponse<>(userService.signUp(user));
        } catch (BaseException exception) {
            return new BaseResponse<>(exception.getStatus());
        }
    }

    // 아이디 중복 확인
    @GetMapping("/id-Check")
    public BaseResponse<Boolean> certifyUsername(@RequestParam String username) {
        try {
            return new BaseResponse<>(userService.certifyUsername(username));
        } catch (BaseException exception) {
            return new BaseResponse<>(exception.getStatus());
        }
    }

    // 로그인
    @PostMapping("/sign-in")
    public BaseResponse<CertifyMemberDto> signIn(@RequestBody SignInDto sign) {
        try {
            return new BaseResponse<>(userService.signIn(sign));
        } catch (BaseException exception) {
            return new BaseResponse<>(exception.getStatus());
        }
    }

    // 유저 정보 조회
    @GetMapping("/user")
    public BaseResponse<UserDto> getUserInfo() {
        try {
            return new BaseResponse<>(userService.getUserInfo());
        } catch (BaseException exception) {
            return new BaseResponse<>(exception.getStatus());
        }
    }

    // 회원정보 수정
    @PatchMapping("/user")
    public BaseResponse<String> modifyUserInfo(@RequestBody UserDto user) {
        try {
            return new BaseResponse<>(userService.modifyUserInfo(user));
        } catch (BaseException exception) {
            return new BaseResponse<>(exception.getStatus());
        }
    }

    // 회원 탈퇴
    @DeleteMapping("/user")
    public BaseResponse<String> deleteUser() {
        try {
            return new BaseResponse<>(userService.deleteUser());
        } catch (BaseException exception) {
            return new BaseResponse<>(exception.getStatus());
        }
    }
}
