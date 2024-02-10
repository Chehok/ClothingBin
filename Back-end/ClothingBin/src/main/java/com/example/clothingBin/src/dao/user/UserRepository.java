package com.example.clothingBin.src.dao.user;

import com.example.clothingBin.src.domain.user.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
//    @Query("select U from User U where U.phoneNum = :phoneNum")
    User findByPhoneNum(String phoneNum);
    User findByUsername(String username);
    User findByPassword(String password);

    boolean existsByUsername(String username);
    boolean existsByPhoneNum(String phoneNum);
}
