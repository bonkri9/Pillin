package com.ssafy.yourpilling.analysis.model.service.vo.out;

import lombok.Builder;
import lombok.Value;

import java.util.List;

@Value
@Builder
public class OutAnalysisVo {

    List<EssentialNutrientsDataList> essentialNutrientsDataList;
    List<VitaminBGroupDataList> vitaminBGroupDataList;
    RecommendList recommendList;

    @Value
    @Builder
    public static class RecommendList {
        List<RecommendPillDataList> data;
    }

    @Value
    @Builder
    public static class RecommendPillDataList {
        String nutritionName;
        List<RecommendPillItem> data;
    }

    @Value
    @Builder
    public static class RecommendPillItem {
        Long pillId;
        Integer rank;
        String pillName;
        String manufacturer;
        String imageUrl;
    }

    @Value
    @Builder
    public static class VitaminBGroupDataList {
        String nutrientsName;
        NutrientItem data;
    }

    @Value
    @Builder
    public static class EssentialNutrientsDataList {
        String nutrientsName;
        NutrientItem data;
    }

    @Value
    @Builder
    public static class NutrientItem{
        Double recommendedIntake;
        Double excessiveIntake;
        Double userIntake;
        String unit;
        String intakeDiagnosis;
    }

}