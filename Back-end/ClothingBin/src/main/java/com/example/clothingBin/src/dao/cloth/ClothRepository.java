package com.example.clothingBin.src.dao.cloth;

import com.example.clothingBin.src.domain.cloth.Cloth;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ClothRepository extends JpaRepository<Cloth, Long> {
    @Query("select C from Cloth C where C.clothingBinId = :clothingBinId")
    List<Cloth> findAllByClothingBinId(Long clothingBinId);

//    @Query("select count (C.clothingBinId) > 0 from Cloth C where C.clothingBinId = :clothingBinId")
    boolean existsByClothingBinId(Long clothingBinId);

    Optional<Cloth> findById(Long clothId);
}