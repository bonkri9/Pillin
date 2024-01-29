package com.ssafy.yourpilling.pill_heeju.model.service.vo.out;

import com.ssafy.yourpilling.common.PillProductForm;
import com.ssafy.yourpilling.pill_heeju.model.dao.entity.HMidCategory;
import lombok.Builder;
import lombok.Value;

import java.time.LocalDate;
import java.util.List;

@Value
@Builder
public class ResponsePillVo {
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
    ResponsePillNutrientsListData nutrientsListData;
    ResponsePillCategoryListData categoryListData;


    @Value
    @Builder
    public static class ResponsePillNutrientsListData{
        List<ResponseNutrientsItem> nutrientsItems;
    }
    @Value
    @Builder
    public static class ResponsePillCategoryListData{
        List<ResponsePillCategoryItem> pillCategoryItems;
    }

    @Value
    @Builder
    public static class ResponseNutrientsItem {
        Long nutritionId;
        String nutrition;
        Double amount;
        String unit;
        String includePercent;
    }

    @Value
    @Builder
    public static class ResponsePillCategoryItem {
        Long mappingId;
        Long midcategoryId;
        String midcategoryName;
    }
}
