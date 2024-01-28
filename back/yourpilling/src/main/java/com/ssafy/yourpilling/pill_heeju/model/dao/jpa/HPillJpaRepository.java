package com.ssafy.yourpilling.pill_heeju.model.dao.jpa;

import com.ssafy.yourpilling.pill_heeju.model.dao.entity.PillDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface HPillJpaRepository extends JpaRepository<PillDetail, Long> {

    Optional<PillDetail> findByPillId(Long aLong);
    List<PillDetail> findByNameContains(String pillName);

    @Query("SELECT p " +
            "FROM PillDetail p " +
            "JOIN p.nutritionDetail n " +
            "WHERE n.nutrition LIKE :nutritionName")
    List<PillDetail> findByNutritionName(@Param("nutritionName")String nutritionName);

    @Query("SELECT p " +
            "FROM PillDetail p " +
            "JOIN p.pillCategories pc " +
            "JOIN pc.midCategory mc " +
            "WHERE mc.midCategoryId IN :categories")
    List<PillDetail> findByCategories(@Param("categories")List<Integer> categories);
}
