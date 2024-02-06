package com.ssafy.yourpilling.pill_heeju.model.dao.jpa;

import com.ssafy.yourpilling.pill_heeju.model.dao.entity.HPill;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface HPillJpaRepository extends JpaRepository<HPill, Long> {

    Optional<HPill> findByPillId(Long aLong);
    @Query("SELECT p " +
            "FROM HPill p " +
            "WHERE p.name LIKE %:searchName% " +
            "OR p.manufacturer LIKE %:searchName% ")
    List<HPill> findByNameAndManufacturer(@Param("searchName") String searchName);

    @Query("SELECT p " +
            "FROM HPill p " +
            "JOIN p.nutritions n " +
            "WHERE n.nutrition LIKE :nutritionName")
    List<HPill> findByNutritionName(@Param("nutritionName")String nutritionName);

    @Query("SELECT p " +
            "FROM HPill p " +
            "JOIN p.pillCategories pc " +
            "JOIN pc.midCategory mc " +
            "WHERE mc.midCategoryId = :categories")
//            "WHERE mc.midCategoryId IN :categories")
//    List<HPill> findByCategories(@Param("categories")List<Integer> categories);
    List<HPill> findByCategories(@Param("categories")Long category);
}
