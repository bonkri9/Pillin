package com.ssafy.yourpilling.analysis.model.service.mapper;

import com.ssafy.yourpilling.analysis.model.service.dto.AnalysisRanksDto;
import com.ssafy.yourpilling.analysis.model.service.dto.AnalysisUserNutrientsDto;
import com.ssafy.yourpilling.analysis.model.service.vo.out.OutAnalysisVo;
import com.ssafy.yourpilling.analysis.model.service.vo.out.OutAnalysisVo.*;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Component
public class AnalysisServiceMapper {

    public OutAnalysisVo mapToAnalysis(List<AnalysisUserNutrientsDto> EssentialValueList,
                                       List<AnalysisUserNutrientsDto> BGroupValueList,
                                       List<AnalysisRanksDto> analysisRanksDtoList) {
        //AnalysisUserNutrientsDto (EssentialValueList, BGroupValueList)
        //AnalysisRanksDto (analysisRanksDtoList)
        //AnalysisOwnPill (ownPillList)에 주의사항
        return OutAnalysisVo
                .builder()
                .essentialNutrientsDataList(mapToessentialNutrientsDataList(EssentialValueList))
                .vitaminBGroupDataList(mapTovitaminBGroupDataList(BGroupValueList))
                .recommendList(mapToRecommendList(analysisRanksDtoList))
                .build();
    }

    public List<VitaminBGroupDataList> mapTovitaminBGroupDataList(List<AnalysisUserNutrientsDto> BGroupValueList){
        List<VitaminBGroupDataList> items = new ArrayList<>();

        for(AnalysisUserNutrientsDto dto : BGroupValueList){
            VitaminBGroupDataList data = VitaminBGroupDataList
                    .builder()
                    .nutrientsName(dto.getNutrition())
                    .data(mapToNutrientItem(dto))
                    .build();
            items.add(data);
        }
        return items;
    }

    public List<EssentialNutrientsDataList> mapToessentialNutrientsDataList(List<AnalysisUserNutrientsDto> EssentialValueList){
        List<EssentialNutrientsDataList> items = new ArrayList<>();

        for(AnalysisUserNutrientsDto dto : EssentialValueList){
            EssentialNutrientsDataList data = EssentialNutrientsDataList
                    .builder()
                    .nutrientsName(dto.getNutrition())
                    .data(mapToNutrientItem(dto))
                    .build();

            items.add(data);
        }
        return items;
    }

    public NutrientItem mapToNutrientItem(AnalysisUserNutrientsDto dto){
        return NutrientItem
                .builder()
                .recommendedIntake(dto.getRecommendedIntake())
                .excessiveIntake(dto.getExcessiveIntake())
                .userIntake(dto.getUserIntake())
                .unit(dto.getUnit())
                .intakeDiagnosis(dto.getIntakeDiagnosis())
                .build();
    }

    public RecommendList mapToRecommendList(List<AnalysisRanksDto> analysisRanksDtoList){
        return RecommendList
                .builder()
                .data(mapToRecommendPillDataList(analysisRanksDtoList))
                .build();
    }

    public List<RecommendPillDataList> mapToRecommendPillDataList(List<AnalysisRanksDto> analysisRanksDtoList){
        Map<String, List<AnalysisRanksDto>> collect = analysisRanksDtoList.stream()
                .collect(Collectors.groupingBy(AnalysisRanksDto::getCategoryNm));
        List<RecommendPillDataList> resultList = new ArrayList<>();

        for(Map.Entry<String, List<AnalysisRanksDto>> entry : collect.entrySet()){
            String key = entry.getKey();
            List<AnalysisRanksDto> values = entry.getValue();

            List<RecommendPillItem> data = new ArrayList<>();
            for(AnalysisRanksDto dto : values){
                data.add(mapToRecommendPillItem(dto));
            }

            resultList.add(RecommendPillDataList.builder()
                    .nutritionName(key)
                    .data(data)
                    .build());
        }

        return resultList;
    }

    public RecommendPillItem mapToRecommendPillItem(AnalysisRanksDto dto){
        return RecommendPillItem
                .builder()
                .pillId(dto.getPillId())
                .rank(dto.getRank())
                .pillName(dto.getPillName())
                .manufacturer(dto.getManufacturer())
                .imageUrl(dto.getImgUrl())
                .build();
    }

}