package com.ssafy.yourpilling.analysis.model.dao.jpa;

import com.ssafy.yourpilling.analysis.model.dao.entity.NutritionStandard;
import com.ssafy.yourpilling.analysis.model.service.dto.AnalysisNutrientsDto;
import com.ssafy.yourpilling.common.Gender;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface NutritionStandardRepository extends JpaRepository<NutritionStandard, Long> {
    @Query("SELECT new com.ssafy.yourpilling.analysis.model.service.dto.AnalysisNutrientsDto(n.nutritionName as nutritionName, n.recommendedIntake as recommendedIntake, n.sufficientIntake as sufficientIntake, n.excessiveIntake as excessiveIntake, n.unit as unit) \n" +
            "FROM NutritionStandard n \n" +
            "WHERE n.nutritionGroup = :groupName and n.gender = :gender and n.ageRange = :ageRange\n")
    List<AnalysisNutrientsDto> findGroupName(@Param("groupName") String groupName,
                                             @Param("gender") String gender, @Param("ageRange") String ageRange);
}
