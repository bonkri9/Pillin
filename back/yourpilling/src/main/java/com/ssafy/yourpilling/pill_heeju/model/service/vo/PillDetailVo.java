package com.ssafy.yourpilling.pill_heeju.model.service.vo;

import lombok.Builder;
import lombok.Value;

import java.time.LocalDate;
import java.util.List;

@Value
@Builder
public class PillDetailVo {
    Long pillId;
    String pillName;
    String manufacturer;
    LocalDate expirationAt;
    String usageInstructions;
    String primaryFunctionality;
    String precautions;
    String storageInstructions;
    String standardSpecification;
    String productForm;
    String imageUrl;
    float takeCount;
    List<NutritionVo> nutrients;
}
