package com.example.clothingBin;

import com.example.clothingBin.config.BaseException;
import com.example.clothingBin.config.BaseResponse;
import com.example.clothingBin.src.dao.bin.BinRepository;
import com.example.clothingBin.src.dao.cloth.ClothRepository;
import com.example.clothingBin.src.dao.cloth.ClothingBinBasketRepository;
import com.example.clothingBin.src.dao.user.CertificationRepository;
import com.example.clothingBin.src.dao.user.UserRepository;
import com.example.clothingBin.src.domain.cloth.Cloth;
import com.example.clothingBin.src.domain.user.Certification;
import com.example.clothingBin.src.domain.user.SignInDto;
import com.example.clothingBin.src.domain.user.User;
import com.example.clothingBin.src.service.BinService;
import com.example.clothingBin.src.service.UserService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.dao.DataAccessException;

import java.util.List;
import java.util.Objects;

import static com.example.clothingBin.config.BaseResponseStatus.CLOTH_NULL;
import static com.example.clothingBin.config.BaseResponseStatus.DATABASE_ERROR;

@SpringBootTest
class HjsApplicationTests {

    @Autowired
    UserRepository userRepository;
    @Autowired
    CertificationRepository certificationRepository;
    @Autowired
    ClothingBinBasketRepository clothingBinBasketRepository;
    @Autowired
    ClothRepository clothRepository;
    @Autowired
    UserService userService;
    @Autowired
    BinService binService;
    @Autowired
    BinRepository binRepository;

//    @Test
//    void Test(){
//        System.out.println(binRepository.findByBinNameAndLatitude("1", 1));
//    }

//    @Test
//    void coord테스트() throws BaseException {
//        Float[] result = binService.findGeoPoint("경기도 성남시 분당구 판교동");
//        System.out.println(result[0] + result[1]);
//    }

//    @Test
//    void 테스트로그인() throws BaseException {
//        SignInDto sign = new SignInDto("username1", "password1");
//        System.out.println(userService.signIn(sign));
//
//        sign.setUsername("username");
//        System.out.println(userService.signIn(sign));
//
//        sign.setPassword("password");
//        System.out.println(userService.signIn(sign));
//    }
//    @Test
//    void 아이디중복확인() throws BaseException {
//        System.out.println(userService.certifyUsername("username"));
//        System.out.println(userService.certifyUsername("asdf"));
//    }
//
//    @Test
//    void 회원가입() throws BaseException {
////        private String username;
////        private String password;
////        private String name;
////        private String profileImg;
////        private String phoneNum;
////        private String email;
////        private char certifyMember;
//
//        User user = new User();
//
//        user.setUsername("username");
//        user.setPassword("password");
//        user.setName("name");
//        user.setProfileImg("profileImg");
//        user.setPhoneNum("01093858858");
//        user.setEmail("email");
//
//        userService.signUp(user);
//    }
//
//    @Test
//    void 로그인() throws BaseException {
//        SignInDto sign = new SignInDto("username1", "password1");
//        System.out.println(userService.signIn(sign));
//
//        sign.setUsername("username");
//        System.out.println(userService.signIn(sign));
//
//        sign.setPassword("password");
//        System.out.println(userService.signIn(sign));
//    }
//
//    @Test
//    void 인증번호저장() {
//        Certification certification = new Certification("01093858858", 12312356);
//
//        certificationRepository.save(certification);
//    }
//    @Test
//    void 인증번호확인() {
//        String phoneNum = "01093858858";
//        int certificationNum = 12312356;
//
//        Certification certification = certificationRepository.findByPhoneNum(phoneNum);
//
//        if(certification == null) {
//            System.out.println("전화번호 없음 or 틀림");
//        } else {
//            if(Objects.equals(certification.getCertificationNum(), certificationNum)){
//                certificationRepository.delete(certification);
//                System.out.println("인증번호 확인");
//                return ;
//            }
//            System.out.println("인증번호 틀림");
//        }
//    }

//    @Test
//    void 쿼리테스트() {
//        System.out.println(test2().getCode());
//        System.out.println(test2().getMessage());
//        System.out.println(test2().getResult());
//        System.out.println(test2().getIsSuccess());
//    }

//    public BaseResponse<String> test2() {
//        try{
//            return new BaseResponse<>(test());
//        }catch (BaseException exception){
//            return new BaseResponse<>(exception.getStatus());
//        }
//    }
//
//    public String test() throws BaseException {
//        if(true){
//            throw new BaseException(CLOTH_NULL);
//        }
//        return "String";
//    }

//    @Test
//    public void getAllClothes() throws BaseException {
//        Long clothingBinId = 2L;
//
//        if (!clothRepository.existsByClothingBinId(clothingBinId)) {
//            throw new BaseException(CLOTH_NULL);
//        }
////        try {
////            clothRepository.findAllByClothingBinId(clothingBinId);
////        } catch (DataAccessException e) {
////            throw new BaseException(DATABASE_ERROR);
////        } catch (Exception e){
////            throw new BaseException(DATABASE_ERROR);
////         }
//    }

//    @Test
//    void contextLoads() {
//        User user = new User(
//                1L,
//                "username",
//                "password",
//                "name",
//                "profileImg",
//                "phoneNum",
//                "email",
//                'Y'
//        );
////        user.setPhoneNum("01093858858");
//
////        User user = User.setPhoneNum("01010101");
//        userRepository.save(user);
//    }

//    @Test
//    void insertNonMember() {
//        String phoneNum = "0109858858";
//        User user = userRepository.findByPhoneNum(phoneNum);
//
//        if(user == null) {
//            user = new User();
//            user.setPhoneNum(phoneNum);
//            user.setCertifyMember('N');
//            System.out.println(userRepository.save(user).getUserId());
//        } else {
//            System.out.println(user.getUserId());
//        }
//    }

//    @Test
//    List<User> test(){
//        Long infoId = 1L;
//        User user = userRepository.findByUserId(infoId);
//        if(user == null){
//            User.builder()
//                    .infoId(infoId)
//                    .build();
//        }else {
//            user.setName("수정");
//        }
//    }

}
