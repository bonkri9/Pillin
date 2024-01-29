package com.ssafy.yourpilling.pill_heeju.model.service.vo;

import com.ssafy.yourpilling.common.PillProductForm;
import com.ssafy.yourpilling.pill_heeju.model.dao.entity.HPillCategory;
import lombok.Builder;
import lombok.Value;

import java.time.LocalDate;
import java.util.List;

@Value
@Builder
public class HPillVo {
    Long pillId;
    String pillName;
    String manufacturer;
    LocalDate expirationAt;
    String usageInstructions;
    String primaryFunctionality;
    String precautions;
    String storageInstructions;
    String standardSpecification;
    PillProductForm productForm;
    String imageUrl;
    int takeCount;
    int takeCycle;
    int takeOnceAmount;
    List<NutritionVo> nutrients;
    List<HPillCategory> pillCategories;
}
