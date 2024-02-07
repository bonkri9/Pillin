package com.ssafy.yourpilling.analysis.model.service.impl;

import com.ssafy.yourpilling.analysis.model.dao.AnalysisDao;
import com.ssafy.yourpilling.analysis.model.dao.entity.AnalysisMember;
import com.ssafy.yourpilling.analysis.model.dao.entity.AnalysisOwnPill;
import com.ssafy.yourpilling.analysis.model.service.AnalysisService;
import com.ssafy.yourpilling.analysis.model.service.dto.AnalysisNutrientsDto;
import com.ssafy.yourpilling.analysis.model.service.dto.AnalysisOwnPillNutritionDto;
import com.ssafy.yourpilling.analysis.model.service.dto.AnalysisRanksDto;
import com.ssafy.yourpilling.analysis.model.service.dto.AnalysisUserNutrientsDto;
import com.ssafy.yourpilling.analysis.model.service.mapper.AnalysisServiceMapper;
import com.ssafy.yourpilling.analysis.model.service.vo.in.AnalysisMemberVo;
import com.ssafy.yourpilling.analysis.model.service.vo.in.AnalysisVo;
import com.ssafy.yourpilling.analysis.model.service.vo.out.OutAnalysisVo;
import com.ssafy.yourpilling.common.AgeGroup;
import com.ssafy.yourpilling.common.Gender;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class AnalysisServiceImpl implements AnalysisService {

    private final AnalysisDao analysisDao;
    private final AnalysisServiceMapper mapper;

    @Override
    public OutAnalysisVo analysis(AnalysisVo vo) { //params : 사용자 아이디
        //사용자 id로 나이대와 gender 추출
        AnalysisMemberVo memberInfo = memberInfo(vo);

        //사용자 복용중인 영양소 총량 조회
        List<AnalysisOwnPillNutritionDto> userNutritionList = ownPillNutritionList(memberInfo.getId());

        //필수 영양소 + B군 영양소 별로 영양소 데이터 매핑 하면서 부족과다 체크
        List<AnalysisUserNutrientsDto> EssentialValueList = setAnalysisNutrientsValue("필수", memberInfo.getGender(), memberInfo.getAgeGroup(), userNutritionList);
        List<AnalysisUserNutrientsDto> BGroupValueList = setAnalysisNutrientsValue("B군", memberInfo.getGender(), memberInfo.getAgeGroup(), userNutritionList);

        //부족 영양소 list
        List<AnalysisRanksDto> analysisRanksDtoList = rankList(EssentialValueList,BGroupValueList);

        return mapper.mapToAnalysis(EssentialValueList, BGroupValueList, analysisRanksDtoList);

    }

    private AnalysisMemberVo memberInfo(AnalysisVo vo){
        AnalysisMember member = analysisDao.findByMemberId(vo.getId());

        if(member == null){
            throw new IllegalArgumentException("사용자 정보가 없습니다.");
        }

        AgeGroup ageGroup = AgeGroup.whatAgeGroup(member.getBirth());

        return AnalysisMemberVo.builder()
                .id(member.getMemberId())
                .gender(member.getGender())
                .ageGroup(ageGroup.toString())
                .build();
    }

    private List<Long> pillIdList(Long id) {

        List<AnalysisOwnPill> ownPillList = analysisDao.findByMemberMemberIdAndTakeYn(id);

        List<Long> pillIdList = new ArrayList<>();
        for(AnalysisOwnPill aop : ownPillList){
            pillIdList.add(aop.getPill().getPillId());
        }

        if(pillIdList.isEmpty()) {
            throw new IllegalArgumentException("복용 중인 영양제가 없어 분석이 불가합니다.");
        }

        return pillIdList;
    }

    private List<AnalysisOwnPillNutritionDto> ownPillNutritionList(Long id){
        //사용자가 먹고 있는 영양제 번호 list 조회
        List<Long> pillIdList = pillIdList(id);
        return analysisDao.groupByNutritionAmount(pillIdList);
    }

    private List<AnalysisUserNutrientsDto> setAnalysisNutrientsValue(String groupName, Gender gender, String ageGroup
                                                                     , List<AnalysisOwnPillNutritionDto> userNutrients){
        //사용자의 섭취 영양소 조회
        List<AnalysisNutrientsDto> nutrientsDtos = analysisDao.findGroupName(groupName, gender.toString(), ageGroup);

        List<AnalysisUserNutrientsDto> IntakeNutrientsList = new ArrayList<>();
        //섭취 영양소 중 영양제 섭취 상태 설정
        for(AnalysisNutrientsDto nutrientsDto : nutrientsDtos){
            String name = nutrientsDto.getNutritionName();
            Double exIntake = nutrientsDto.getExcessiveIntake();
            String unit = nutrientsDto.getUnit();
            Double reIntake = nutrientsDto.getRecommendedIntake() != 0 ? nutrientsDto.getRecommendedIntake() : nutrientsDto.getSufficientIntake();
            Double userIntake = 0.0;
            String intakeDiagnosis = "부족";
            for(AnalysisOwnPillNutritionDto ownPillNutritionDto : userNutrients){
                if(ownPillNutritionDto.getNutritionName().equals(nutrientsDto.getNutritionName())){

                    userIntake = ownPillNutritionDto.getAmount();

                    if(exIntake != 0){
                        if(userIntake < reIntake){
                            intakeDiagnosis = "부족";
                        }else if (userIntake < exIntake) {
                            intakeDiagnosis = "적절";
                        }else {
                            intakeDiagnosis = "과다";
                        }
                    }else {
                        if(userIntake < reIntake){
                            intakeDiagnosis = "부족";
                        }else {
                            intakeDiagnosis = "적절";
                        }
                    }
                }
            }
            IntakeNutrientsList.add(new AnalysisUserNutrientsDto(name, reIntake, exIntake, userIntake, unit, intakeDiagnosis));
        }
        return IntakeNutrientsList;
    }

    private List<String> intakeDiagnosisLessStateList(List<AnalysisUserNutrientsDto> essentialList,
                                                      List<AnalysisUserNutrientsDto> bGroupList){

        List<String> lessStateList = new ArrayList<>();
        for(AnalysisUserNutrientsDto dto : essentialList){
            if(dto.getIntakeDiagnosis().equals("부족")){
                lessStateList.add(dto.getNutrition());
            }
        }
        for(AnalysisUserNutrientsDto dto : bGroupList){
            if(dto.getIntakeDiagnosis().equals("부족")){
                lessStateList.add(dto.getNutrition());
            }
        }

        return lessStateList;
    }

    private List<AnalysisRanksDto> rankList(List<AnalysisUserNutrientsDto> essentialList,
                                      List<AnalysisUserNutrientsDto> bGroupList){
        List<String>  intakeDiagnosisLessStateList = intakeDiagnosisLessStateList(essentialList, bGroupList);
        List<AnalysisRanksDto> analysisRanksDtoList = new ArrayList<>();
        if(!intakeDiagnosisLessStateList.isEmpty()){
            analysisRanksDtoList = analysisDao.recommendPillByLessNutrition(intakeDiagnosisLessStateList);
        }

        return analysisRanksDtoList;
    }

}
