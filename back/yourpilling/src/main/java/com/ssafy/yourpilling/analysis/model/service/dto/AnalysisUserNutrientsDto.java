package com.ssafy.yourpilling.analysis.model.service.dto;

import lombok.*;

@Builder
@AllArgsConstructor
@Getter
@NoArgsConstructor
@ToString
public class AnalysisUserNutrientsDto {
    String nutrition;
    Double recommendedIntake;
    Double excessiveIntake;
    Double userIntake;
    String unit;
    String intakeDiagnosis;
}
