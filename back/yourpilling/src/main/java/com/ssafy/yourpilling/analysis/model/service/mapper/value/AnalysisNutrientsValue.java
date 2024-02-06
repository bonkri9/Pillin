package com.ssafy.yourpilling.analysis.model.service.mapper.value;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class AnalysisNutrientsValue {
    String nutrition;
    Double recommendedIntake;
    Double excessiveIntake;
    Double userIntake;
    String unit;
    String intakeDiagnosis;
}
