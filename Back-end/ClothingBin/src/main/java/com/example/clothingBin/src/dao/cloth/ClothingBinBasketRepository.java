package com.example.clothingBin.src.dao.cloth;

import com.example.clothingBin.src.domain.cloth.ClothingBinBasket;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ClothingBinBasketRepository extends JpaRepository<ClothingBinBasket, Long> {

}
