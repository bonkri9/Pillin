package com.ssafy.yourpilling.analysis.model.service.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Value;

@AllArgsConstructor
@Builder
@Getter
public class AnalysisOwnPillNutritionDto {
    String nutritionName;
    Double amount;
    String unit;
}
