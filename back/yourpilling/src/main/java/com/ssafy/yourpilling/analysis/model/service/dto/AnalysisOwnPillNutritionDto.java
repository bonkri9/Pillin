package com.ssafy.yourpilling.analysis.model.service.dto;

import lombok.*;

@AllArgsConstructor
@Builder
@Getter
@ToString
public class AnalysisOwnPillNutritionDto {
    String nutritionName;
    Double amount;
    String unit;
}
