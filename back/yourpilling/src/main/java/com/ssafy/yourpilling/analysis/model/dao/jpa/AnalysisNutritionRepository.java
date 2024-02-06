package com.ssafy.yourpilling.analysis.model.dao.jpa;

import com.ssafy.yourpilling.analysis.model.dao.entity.AnalysisNutrition;
import com.ssafy.yourpilling.analysis.model.service.dto.AnalysisOwnPillNutritionDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
public interface AnalysisNutritionRepository extends JpaRepository<AnalysisNutrition, Long> {

    @Query("select new com.ssafy.yourpilling.analysis.model.service.dto.AnalysisOwnPillNutritionDto( n.nutrition as nutritionName, sum(n.amount) as amount, n.unit as unit) \n" +
            "from AnalysisNutrition n \n" +
            "inner join n.pill p\n" +
            "where p.pillId in :pillIdList\n" +
            "group by n.nutrition ")
    List<AnalysisOwnPillNutritionDto> groupByNutritionAmount(@Param("pillIdList") List<Long> pillIdList);
}
