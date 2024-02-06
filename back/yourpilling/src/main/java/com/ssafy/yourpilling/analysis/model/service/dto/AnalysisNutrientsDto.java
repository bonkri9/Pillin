package com.ssafy.yourpilling.analysis.model.service.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@Getter
@NoArgsConstructor
public class AnalysisNutrientsDto {
    String nutritionName;
    Double recommendedIntake;
    Double sufficientIntake;
    Double excessiveIntake;
    Double userIntake;
    String unit;

}

