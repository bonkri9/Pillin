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
import com.ssafy.yourpilling.analysis.model.service.vo.out.OutAnalysisVo;
import com.ssafy.yourpilling.common.AgeGroup;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class AnalysisServiceImpl implements AnalysisService {

    private final AnalysisDao analysisDao;
    private final AnalysisServiceMapper mapper;

    @Override
    public OutAnalysisVo analysis(Long id) { //params : 사용자 아이디
        //사용자 id로 나이대와 gender 추출
        AnalysisMember member = analysisDao.findByMemberId(id);
        LocalDate birthday = member.getBirth();
        AgeGroup ageGroup = AgeGroup.whatAgeGroup(birthday);

        //사용자가 먹고 있는 영양제 조회 -> 영양제 번호랑 주의사항 추출???
        List<AnalysisOwnPill> ownPillList = analysisDao.findByMemberMemberIdAndTakeYn(member.getMemberId());

        if(ownPillList.isEmpty()) {
            throw new IllegalArgumentException("복용 중인 영양제가 없어 분석이 불가합니다.");
        }

        List<Long> pillIdList = pillIdList(ownPillList);
        //사용자 복용중인 영양소 총량 조회
        List<AnalysisOwnPillNutritionDto> userNutritionList = analysisDao.groupByNutritionAmount(pillIdList);


        //필수 영양소 + B군 영양소 별로 영양소 데이터 매핑 하면서 부족과다 체크 => 객체 필요
        List<AnalysisNutrientsDto> EssentialList = analysisDao.findGroupName("필수", member.getGender().toString(), ageGroup.toString());
        List<AnalysisNutrientsDto> BGroupList = analysisDao.findGroupName("B군", member.getGender().toString(), ageGroup.toString());

        List<AnalysisUserNutrientsDto> EssentialValueList = setAnalysisNutrientsValue(EssentialList, userNutritionList);
        List<AnalysisUserNutrientsDto> BGroupValueList = setAnalysisNutrientsValue(BGroupList, userNutritionList);
        printList(EssentialValueList);
        printList(BGroupValueList);

        //부족 영양소 list
        List<String>  intakeDiagnosisLessStateList = intakeDiagnosisLessStateList(EssentialValueList, BGroupValueList);
        List<AnalysisRanksDto> analysisRanksDtoList = new ArrayList<>();
        if(!intakeDiagnosisLessStateList.isEmpty()){
            analysisRanksDtoList = analysisDao.recommendPillByLessNutrition(intakeDiagnosisLessStateList);
        }

        //mapper
        //AnalysisUserNutrientsDto (EssentialValueList, BGroupValueList)
        //AnalysisRanksDto (analysisRanksDtoList)
        //AnalysisOwnPill (ownPillList)에 주의사항


        //mapper로 "" 형식으로 return
        return mapper.mapToAnalysis(EssentialValueList, BGroupValueList, analysisRanksDtoList);

    }

    private List<Long> pillIdList(List<AnalysisOwnPill> pillList) {

        List<Long> pillIdList = new ArrayList<>();
        for(AnalysisOwnPill aop : pillList){
            pillIdList.add(aop.getPill().getPillId());
        }

        return pillIdList;
    }

    private List<AnalysisUserNutrientsDto> setAnalysisNutrientsValue(List<AnalysisNutrientsDto> nutrients,
                                                                   List<AnalysisOwnPillNutritionDto> userNutrients){
        List<AnalysisUserNutrientsDto> IntakeNutrientsList = new ArrayList<>();

        for(AnalysisNutrientsDto nutrientsDto : nutrients){
            String name = nutrientsDto.getNutritionName();
            Double exIntake = nutrientsDto.getExcessiveIntake();
            String unit = nutrientsDto.getUnit();
            Double reIntake = nutrientsDto.getRecommendedIntake() != 0 ? nutrientsDto.getRecommendedIntake() : nutrientsDto.getSufficientIntake();
            Double userIntake = 0.0;
            String intakeDiagnosis = "";
            for(AnalysisOwnPillNutritionDto ownPillNutritionDto : userNutrients){
                if(ownPillNutritionDto.getNutritionName().equals(nutrientsDto.getNutritionName())){

                    userIntake = ownPillNutritionDto.getAmount();
                    intakeDiagnosis = "";

                    if(userIntake < reIntake){
                        intakeDiagnosis = "부족";
                    }else if(userIntake >= reIntake && userIntake < exIntake){
                        intakeDiagnosis = "적절";
                    }else{
                        intakeDiagnosis = "과다";
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

    private void printList (List<AnalysisUserNutrientsDto> list){
        for(AnalysisUserNutrientsDto dto : list){
            System.out.println("{" + dto.getNutrition() + ", " +
                    dto.getRecommendedIntake() + ", " +
                    dto.getExcessiveIntake() + ", " +
                    dto.getUserIntake() + ", " +
                    dto.getIntakeDiagnosis() + "," +
                    dto.getUnit() + "}");
        }
    }
}
