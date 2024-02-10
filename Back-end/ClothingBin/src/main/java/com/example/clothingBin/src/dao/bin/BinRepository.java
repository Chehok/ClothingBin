package com.example.clothingBin.src.dao.bin;

import com.example.clothingBin.src.domain.bin.Bin;
import com.example.clothingBin.src.domain.bin.BinDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface BinRepository extends JpaRepository<Bin, Long> {
//    Optional<List<Bin>>findByClothingBinId(Long id);


//    @Query("select new com.example.clothingBin.src.domain.bin.BinDto(P) " +
//            "from Bin P where P.clothingBinId = :id")
//    Optional<BinDto> findByProductIdDtl(Long id);
//    Optional<Bin> findByProductId(Long id);
    List<Bin> findByBinNameAndLatitude(String binName, float latitude);
}
