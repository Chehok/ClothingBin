package com.example.clothingBin.src.domain.user;

import com.example.clothingBin.utils.JwtService;
import com.querydsl.core.annotations.QueryProjection;
import lombok.*;

@Data
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class CertifyMemberDto {
    private JwtService jwtService;
    private String userId;
    private char certifyMember;

    @QueryProjection
    public CertifyMemberDto(char certifyMember, String userId) {
        this.userId = userId;
        this.certifyMember = certifyMember;
    }
    @QueryProjection
    public CertifyMemberDto(User user) {
        this.userId = jwtService.createJwt(user.getUserId());
        this.certifyMember = user.getCertifyMember();
    }
}
