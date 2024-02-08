package com.ssafy.yourpilling.analysis.model.service.dto;

import lombok.*;

@Builder
@AllArgsConstructor
@Getter
@NoArgsConstructor
@ToString
public class AnalysisNutrientsDto {
    String nutritionName;
    Double recommendedIntake;
    Double sufficientIntake;
    Double excessiveIntake;
    Double userIntake;
    String unit;

}

