package com.ssafy.yourpilling.pill_heeju.controller.dto.response;

import lombok.Data;

@Data
public class ResponseNutritionInfoDto {
    private Long nutritionId;
    private String nutrition;
    private float amount;
    private String unit;
    private float includePercent;
}
