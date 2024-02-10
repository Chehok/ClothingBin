package com.example.clothingBin.utils;

import com.example.clothingBin.config.BaseException;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.UnsupportedJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.stereotype.Component;

import java.security.Key;

import static com.example.clothingBin.config.BaseResponseStatus.INVALID_JWT;

@Slf4j
@Component
public class JwtUtils {

    private final Key jwtSecretKey;

    public JwtUtils(@Value("${secretKey.JWT}") String secretKey) {
        byte[] keyBytes = Decoders.BASE64.decode(secretKey);
        jwtSecretKey = Keys.hmacShaKeyFor(keyBytes);
    }

    public String extractJwt(final StompHeaderAccessor accessor) {
        return accessor.getFirstNativeHeader("Authorization");
    }

    // jwt 인증
    public void validateToken(final String token) {
        try {
            Jwts.parserBuilder().setSigningKey(jwtSecretKey).build().parseClaimsJws(token);
        } catch (io.jsonwebtoken.security.SecurityException | MalformedJwtException e) {
//            throw BaseException(INVALID_JWT);
        } catch (ExpiredJwtException e) {
//            throw UnauthorizedException.of(e.getClass().getName(),"만료된 JWT 토큰입니다.");
        } catch (UnsupportedJwtException e) {
//            throw UnauthorizedException.of(e.getClass().getName(),"지원되지 않는 JWT 토큰입니다.");
        } catch (IllegalArgumentException e) {
//            throw UnauthorizedException.of(e.getClass().getName(),"JWT 토큰이 잘못되었습니다.");
        }
    }
}