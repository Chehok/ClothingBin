package com.example.clothingBin.src.domain.user;

import com.example.clothingBin.src.domain.bin.Bin;
import com.querydsl.core.annotations.QueryProjection;
import lombok.*;

@Data
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class UserDto {
    private String name;
    private String profileImg;
    private String phoneNum;
    private String email;
//    private String certifyMember;

    @QueryProjection
    public UserDto(User user) {
        this.name = user.getName();
        this.profileImg = user.getProfileImg();
        this.phoneNum = user.getPhoneNum();
        this.email = user.getEmail();
//        this.certifyMember = getCertifyMember();
    }
}
