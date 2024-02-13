package com.ssafy.yourpilling.analysis.model.dao.impl;

import com.ssafy.yourpilling.analysis.model.dao.AnalysisDao;
import com.ssafy.yourpilling.analysis.model.dao.entity.AnalysisMember;
import com.ssafy.yourpilling.analysis.model.dao.entity.AnalysisOwnPill;
import com.ssafy.yourpilling.analysis.model.dao.jpa.*;
import com.ssafy.yourpilling.analysis.model.service.dto.AnalysisNutrientsDto;
import com.ssafy.yourpilling.analysis.model.service.dto.AnalysisOwnPillNutritionDto;
import com.ssafy.yourpilling.analysis.model.service.dto.AnalysisRanksDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class AnalysisDaoImpl implements AnalysisDao {
    private final AnalysisOwnPillRepository analysisOwnPillRepository;
    private final NutritionStandardRepository nutritionStandardRepository;
    private final AnalysisNutritionRepository analysisNutritionRepository;
    private final AnalysisMemberRepository analysisMemberRepository;
    private final AnalysisRankRepository analysisRankRepository;
    @Override
    public List<AnalysisOwnPill> findByMemberMemberIdAndTakeYn(Long memberId) {
        return analysisOwnPillRepository.findByMemberMemberIdAndTakeYn(memberId, true);
    }

    @Override
    public List<AnalysisNutrientsDto> findGroupName(String groupName, String gender, String ageRange) {
        return nutritionStandardRepository.findGroupName(groupName, gender, ageRange);
    }

    @Override
    public List<AnalysisOwnPillNutritionDto> groupByNutritionAmount(List<Long> pillIdList) {
        return analysisNutritionRepository.groupByNutritionAmount(pillIdList);
    }

    @Override
    public AnalysisMember findByMemberId(Long memberId) {
        return analysisMemberRepository.findByMemberId(memberId)
                .orElseThrow(() -> new IllegalArgumentException("사용자를 찾을 수 없습니다."));
    }

    @Override
    public List<AnalysisRanksDto> recommendPillByLessNutrition(List<String> nutrition) {
        return analysisRankRepository.recommendPillByLessNutrition( nutrition);
    }


}
