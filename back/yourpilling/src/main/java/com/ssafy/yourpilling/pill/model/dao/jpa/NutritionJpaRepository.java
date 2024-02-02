package com.ssafy.yourpilling.pill.model.dao.jpa;

import com.ssafy.yourpilling.pill.model.dao.entity.Nutrition;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface NutritionJpaRepository extends JpaRepository<Nutrition, Long> {

    Optional<Nutrition> findByNutrition(String name);
}
