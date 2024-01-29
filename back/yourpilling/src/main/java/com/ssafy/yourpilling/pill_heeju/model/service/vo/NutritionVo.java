package com.ssafy.yourpilling.pill_heeju.model.service.vo;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class NutritionVo {
    Long nutritionId;
    String nutrition;
    Double amount;
    String unit;
    Double includePercent;
}
