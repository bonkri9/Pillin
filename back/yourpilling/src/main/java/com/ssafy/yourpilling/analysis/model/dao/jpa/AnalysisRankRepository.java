package com.ssafy.yourpilling.analysis.model.dao.jpa;

import com.ssafy.yourpilling.analysis.model.dao.entity.AnalysisRank;
import com.ssafy.yourpilling.analysis.model.service.dto.AnalysisRanksDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface AnalysisRankRepository extends JpaRepository<AnalysisRank, Long> {

    @Query("select new com.ssafy.yourpilling.analysis.model.service.dto.AnalysisRanksDto(r.rank as rank ,r.weeks as weeks, m.categoryNm as categoryNm, p.name as pillName" +
            ", p.pillId as pillId, p.manufacturer as manufacturer, p.imageUrl as imgUrl) \n" +
            "from AnalysisRank r\n" +
            "join r.midCategory m \n" +
            "join r.pill p \n" +
            "where WEEK(NOW()) = r.weeks and r.year = year(now())\n" +
            "and m.categoryNm in :nutrition\n" )
    List<AnalysisRanksDto> recommendPillByLessNutrition(@Param("nutrition")List<String> nutrition);

}
