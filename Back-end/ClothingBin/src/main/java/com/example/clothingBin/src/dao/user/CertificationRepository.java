package com.example.clothingBin.src.dao.user;

import com.example.clothingBin.src.domain.user.Certification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CertificationRepository extends JpaRepository<Certification, String> {
    Certification findByPhoneNum(String phoneNum);
}
