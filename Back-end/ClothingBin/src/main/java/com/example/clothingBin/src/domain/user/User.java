package com.example.clothingBin.src.domain.user;

import lombok.*;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.springframework.security.crypto.password.PasswordEncoder;

import javax.persistence.*;

@Getter
@Setter
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "Users")
//@AllArgsConstructor
//@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "userId")
    private Long userId;

    private String username;
    private String password;
    private String name;
    private String profileImg;
    private String phoneNum;
    private String email;
    private char certifyMember;

    public void hashPassword(PasswordEncoder passwordEncoder) {
        this.password = passwordEncoder.encode(this.password);
//        return this;
    }

    public boolean checkPassword(String plainPassword, PasswordEncoder passwordEncoder) {
        return passwordEncoder.matches(plainPassword, this.password);
    }
}
