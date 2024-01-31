package com.ssafy.yourpilling.pill_heeju.controller.dto.response;

import lombok.Data;

import java.time.LocalDate;
import java.util.List;


@Data
public class ResponsePillDetailDto {
    private String pillName;
    private String manufacturer;
    private LocalDate expirationAt;
    private String usageInstructions;
    private String primaryFunctionality;
    private String precautions;
    private String storageInstructions;
    private String standardSpecification;
    private String productForm;
    private String imageUrl;
    private float takeCount;
    private List<ResponseNutritionInfoDto> nutrients;
}
