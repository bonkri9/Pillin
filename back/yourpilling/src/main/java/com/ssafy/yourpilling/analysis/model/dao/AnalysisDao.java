package com.ssafy.yourpilling.analysis.model.dao;

import com.ssafy.yourpilling.analysis.model.dao.entity.AnalysisMember;
import com.ssafy.yourpilling.analysis.model.dao.entity.AnalysisOwnPill;
import com.ssafy.yourpilling.analysis.model.service.dto.AnalysisNutrientsDto;
import com.ssafy.yourpilling.analysis.model.service.dto.AnalysisOwnPillNutritionDto;
import com.ssafy.yourpilling.analysis.model.service.dto.AnalysisRanksDto;
import com.ssafy.yourpilling.common.Gender;

import java.util.List;

public interface AnalysisDao {

    List<AnalysisOwnPill> findByMemberMemberIdAndTakeYn(Long memberId);
    List<AnalysisNutrientsDto> findGroupName(String groupName, String gender, String ageRange);

    List<AnalysisOwnPillNutritionDto> groupByNutritionAmount(List<Long> pillIdList);

    AnalysisMember findByMemberId(Long memberId);

    List<AnalysisRanksDto> recommendPillByLessNutrition(List<String> nutrition);
}
