package com.example.clothingBin.src.service;


import com.example.clothingBin.config.BaseException;
import com.example.clothingBin.src.dao.user.CertificationRepository;
import com.example.clothingBin.src.dao.user.UserRepository;
import com.example.clothingBin.src.domain.user.*;
import com.example.clothingBin.utils.JwtService;
//import com.google.gson.JsonElement;
//import com.google.gson.JsonParser;
import lombok.RequiredArgsConstructor;

import lombok.extern.slf4j.Slf4j;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.*;
import java.util.concurrent.ThreadLocalRandom;

import static com.example.clothingBin.config.BaseResponseStatus.*;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserService {

    private final JwtService jwtService;
    private final UserRepository userRepository;
    private final CertificationRepository certificationRepository;
    private final PasswordEncoder bCryptPasswordEncoder;

    public List<User> get() {
        return userRepository.findAll();
    }

//    public List<UserDto> getTest(){
//        return userRepository.getTest();
//    }

    // ========================================================================
    // 비회원 로직

    // 인증번호 6자리 생성
    private int makeCertificationNumber() {
        return ThreadLocalRandom.current().nextInt(100000, 1000000);
    }

    // SMS전송을 위한 timestamp 등 헤더 작업
    private String makeSignature(String url, String timestamp, String method, String accessKey, String secretKey) throws NoSuchAlgorithmException, InvalidKeyException {
        String space = " ";                    // one space
        String newLine = "\n";                 // new line


        String message = new StringBuilder()
                .append(method)
                .append(space)
                .append(url)
                .append(newLine)
                .append(timestamp)
                .append(newLine)
                .append(accessKey)
                .toString();

        SecretKeySpec signingKey;
        String encodeBase64String;
        try {

            signingKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256");
            Mac mac = Mac.getInstance("HmacSHA256");
            mac.init(signingKey);
            byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
            encodeBase64String = Base64.getEncoder().encodeToString(rawHmac);
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            encodeBase64String = e.toString();
        }


        return encodeBase64String;
    }

    // Naver sms 전송 api 메서드
    public void sendSMS(String phoneNum) throws BaseException {
        String hostNameUrl = "https://sens.apigw.ntruss.com";            // 호스트 URL
        String requestUrl = "/sms/v2/services/";                        // 요청 URL
        String requestUrlType = "/messages";                            // 요청 URL
        String accessKey = "xew13KI8UCXqlmYIc7FU";                        // 네이버 클라우드 플랫폼 회원에게 발급되는 개인 인증키			// Access Key : https://www.ncloud.com/mypage/manage/info > 인증키 관리 > Access Key ID
        String secretKey = "rFnLK4uaIySURuYNgONqgFJEvUujlWpc7jkmRKBu";  // 2차 인증을 위해 서비스마다 할당되는 service secret key	// Service Key : https://www.ncloud.com/mypage/manage/info > 인증키 관리 > Access Key ID
        String serviceId = "ncp:sms:kr:305557381485:smart_clothingbin";       // 프로젝트에 할당된 SMS 서비스 ID							// service ID : https://console.ncloud.com/sens/project > Simple & ... > Project > 서비스 ID
        String method = "POST";                                            // 요청 method
        String timestamp = Long.toString(System.currentTimeMillis());    // current timestamp (epoch)
        requestUrl += serviceId + requestUrlType;
        String apiUrl = hostNameUrl + requestUrl;

        // JSON 을 활용한 body data 생성
        JSONObject bodyJson = new JSONObject();
        JSONObject toJson = new JSONObject();
        JSONArray toArr = new JSONArray();
        int certificationNum = makeCertificationNumber();
        String message = "Certification Number: [" + certificationNum + "]";

        //toJson.put("subject","");							// Optional, messages.subject	개별 메시지 제목, LMS, MMS에서만 사용 가능
        //toJson.put("content","sms test in spring 111");	// Optional, messages.content	개별 메시지 내용, SMS: 최대 80byte, LMS, MMS: 최대 2000byte
        toJson.put("to", phoneNum);                        // Mandatory(필수), messages.to	수신번호, -를 제외한 숫자만 입력 가능
        toArr.put(toJson);

        bodyJson.put("type", "SMS");                            // Madantory, 메시지 Type (SMS | LMS | MMS), (소문자 가능)
        //bodyJson.put("contentType","");					// Optional, 메시지 내용 Type (AD | COMM) * AD: 광고용, COMM: 일반용 (default: COMM) * 광고용 메시지 발송 시 불법 스팸 방지를 위한 정보통신망법 (제 50조)가 적용됩니다.
        //bodyJson.put("countryCode","82");					// Optional, 국가 전화번호, (default: 82)
        bodyJson.put("from", "01093858858");                    // Mandatory, 발신번호, 사전 등록된 발신번호만 사용 가능
        //bodyJson.put("subject","");						// Optional, 기본 메시지 제목, LMS, MMS에서만 사용 가능
        bodyJson.put("content", message);    // Mandatory(필수), 기본 메시지 내용, SMS: 최대 80byte, LMS, MMS: 최대 2000byte
        bodyJson.put("messages", toArr);                    // Mandatory(필수), 아래 항목들 참조 (messages.XXX), 최대 1,000개

        String body = bodyJson.toString();

        try {
            URL url = new URL(apiUrl);

            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setUseCaches(false);
            con.setDoOutput(true);
            con.setDoInput(true);
            con.setRequestProperty("content-type", "application/json");
            con.setRequestProperty("x-ncp-apigw-timestamp", timestamp);
            con.setRequestProperty("x-ncp-iam-access-key", accessKey);
            con.setRequestProperty("x-ncp-apigw-signature-v2", makeSignature(requestUrl, timestamp, method, accessKey, secretKey));
            con.setRequestMethod(method);
            con.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());

            wr.write(body.getBytes());
            wr.flush();
            wr.close();

            // sms 요청 끝.

            int responseCode = con.getResponseCode();
            BufferedReader br;
            System.out.println("responseCode" + " " + responseCode);
            if (responseCode == 202) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));

                certificationRepository.save(new Certification(phoneNum, certificationNum));
            } else { // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }

            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();

//            return response.toString();
        } catch (Exception exception) {
            throw new BaseException(NAVER_SMS_API_ERROR);
        }
    }

    // Naver sms api 횟수 제한으로 인해 인증번호 전송을 response로 구현한 로직
    public String testSMS(String phoneNum) throws BaseException {
        try {
            int certificationNum = makeCertificationNumber();
            // 인증번호 재전송 시, 기존 전화번호에 대한 인증번호 삭제 로직.
            certificationRepository.save(new Certification(phoneNum, certificationNum));

            return String.valueOf(certificationNum);
        } catch (Exception e) {
            throw new BaseException(DATABASE_ERROR);
        }
    }

    // 인증번호 확인절차 및 비회원 등록
    public CertifyMemberDto certificationSMS(CertificationNumDto certificationNumDto) throws BaseException {
        Certification certification = certificationRepository.findByPhoneNum(certificationNumDto.getPhoneNum());

        if (certification == null) {
            throw new BaseException(PHONE_NUMBER_ERROR);
        } else {
            if (Objects.equals(certification.getCertificationNum(), certificationNumDto.getCertificationNum())) {
                try {
                    User user = userRepository.findByPhoneNum(certificationNumDto.getPhoneNum());

                    if (user == null) {
                        user = new User();
                        user.setPhoneNum(certificationNumDto.getPhoneNum());
                        user.setCertifyMember('N'); // 'N'
                        Long guestId = userRepository.save(user).getUserId();
                        user = userRepository.findById(guestId).orElse(null);
                    }
                    certificationRepository.delete(certification); // 미작동
                    return new CertifyMemberDto(user);
                } catch (Exception exception) {
                    throw new BaseException(DATABASE_ERROR);
                }
            }
            throw new BaseException(CERTIFICATIOM_ERROR);
        }
    }

    // ========================================================================
    // 회원 로직

    // 중복 아이디 검사
    public boolean certifyUsername(String username) throws BaseException {
        try {
            return userRepository.existsByUsername(username);

        } catch (Exception exception) {
            throw new BaseException(DATABASE_ERROR);
        }
    }

    // 회원가입
    public String signUp(User user) throws BaseException {
        try {
            if (certifyUsername(user.getUsername())) {
                throw new BaseException(ALREADY_EXIST_ID);
            }

            if (userRepository.existsByPhoneNum(user.getPhoneNum())) {
                // 만약 있다면? 비회원인지 아닌지 확인해야 함.
                User certifyUser = userRepository.findByPhoneNum(user.getPhoneNum());

                if (certifyUser.getCertifyMember() == 'Y') { // 'Y'
                    // 이미 가입한 회원임.
                    throw new BaseException(ALREADY_EXIST_PHONE_NUMBER);

                } else { //'N'
                    // 비회원인 상태 -> 번호만 저장됨.
                    user.setUserId(certifyUser.getUserId());
                }
            }

            user.setCertifyMember('Y'); // 'Y'
            user.hashPassword(bCryptPasswordEncoder);
            userRepository.save(user);
            return "회원가입 되었습니다.";
        } catch (BaseException exception) {
            throw exception;
        } catch (Exception exception) {
            throw new BaseException(DATABASE_ERROR);
        }
    }

    // 로그인
    public CertifyMemberDto signIn(SignInDto sign) throws BaseException {
        try { // 아이디에 해당하는 유저정보가 있는가?
            if (!userRepository.existsByUsername(sign.getUsername()))
                throw new BaseException(ID_ERROR);

            // 아이디에 해당하는 유저정보 가져오기
            User user = userRepository.findByUsername(sign.getUsername());

            // 비밀번호 일치하는지 확인
//            if (Objects.equals(user.getPassword(), sign.getPassword())) {
//            if (bCryptPasswordEncoder.matches(sign.getPassword(), user.getPassword())) {
            if (user.checkPassword(sign.getPassword(), bCryptPasswordEncoder)) {
                return new CertifyMemberDto(user);
            }

            // 비밀번호 틀리는 예외상황
            throw new BaseException(PASSWORD_ERROR);
        } catch (BaseException e) { // try 문에서 throw BaseException 을 하면 BaseException 을 먼저 catch 할 수 있게 함.
            throw e;
        } catch (Exception e) { // 그 외 Exception 에 대해서 catch 해줌.
            log.error(e.getMessage(), e);
            throw new BaseException(DATABASE_ERROR);
        }
    }

    // 유저 정보 조회
    public UserDto getUserInfo() throws BaseException {
        try {
            if (!userRepository.existsById(jwtService.getUserId())) {
                throw new BaseException(USERS_EMPTY_USER_ID);
            }

            User user = userRepository.findById(jwtService.getUserId()).orElse(null);
            return new UserDto(user);
        } catch (BaseException e) {
            throw e;
        } catch (Exception e) {
            throw new BaseException(DATABASE_ERROR);
        }
    }

    // 회원정보 수정
    public String modifyUserInfo(UserDto user) throws BaseException {
        try {
            if (!userRepository.existsById(jwtService.getUserId())) {
                throw new BaseException(ID_ERROR);
            }
            User modifiedUser = userRepository.findById(jwtService.getUserId()).orElse(null);

            if (user.getName() != null) modifiedUser.setName(user.getName());
            if (user.getEmail() != null) modifiedUser.setEmail(user.getEmail());
            if (user.getProfileImg() != null) modifiedUser.setProfileImg(user.getProfileImg());
            if (user.getPhoneNum() != null) modifiedUser.setPhoneNum(user.getPhoneNum());

            userRepository.save(modifiedUser);

            return "회원 정보 수정됨";
        } catch (BaseException e) {
            throw e;
        } catch (Exception exception) {
            throw new BaseException(DATABASE_ERROR);
        }
    }

    // 회원탈퇴
    public String deleteUser() throws BaseException {
        try {
            if (!userRepository.existsById(jwtService.getUserId())) {
                throw new BaseException(ID_ERROR);
            }
            userRepository.deleteById(jwtService.getUserId());
            return "회원 탈퇴됨";
        } catch (BaseException e) {
            throw e;
        } catch (Exception exception) {
            throw new BaseException(DATABASE_ERROR);
        }
    }

    // ========================================================================

    @Transactional(rollbackFor = {SQLException.class, Exception.class})
    public void saveProfile(String name, Long userId) throws BaseException {
        try {
            User user = userRepository.findById(userId).orElse(null);
            user.setName(name);
            userRepository.save(user);

        } catch (Exception exception) {
            throw new BaseException(DATABASE_ERROR);
        }
    }

    public Optional<User> getUserInfoRes(Long userId) throws BaseException {
        try {
            return userRepository.findById(userId);
        } catch (Exception exception) {
            throw new BaseException(DATABASE_ERROR);
        }
    }
}
