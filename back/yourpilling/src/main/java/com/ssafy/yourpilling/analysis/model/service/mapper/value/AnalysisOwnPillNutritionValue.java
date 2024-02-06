package com.ssafy.yourpilling.analysis.model.service.mapper.value;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class AnalysisOwnPillNutritionValue {
    String nutritionName;
    Double amount;
    String unit;
}
