package com.ssafy.yourpilling.pill_heeju.model.service.mapper;

import com.ssafy.yourpilling.pill_heeju.model.dao.entity.HPill;
import com.ssafy.yourpilling.pill_heeju.model.dao.entity.HNutrition;
import com.ssafy.yourpilling.pill_heeju.model.dao.entity.HPillCategory;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.MidCategoryVo;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.NutritionVo;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.HPillVo;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.out.ResponsePillSearchListVo.ResponsePillSearchItem;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.out.ResponsePillSearchListVo.ResponsePillSearchListData;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.out.ResponsePillVo;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

import static com.ssafy.yourpilling.pill_heeju.model.service.vo.out.ResponsePillVo.*;

@Component
public class HPillServiceMapper {

    public HPill mapToPillId(HPillVo vo){
        return HPill.builder().pillId(vo.getPillId()).build();
    }
    public ResponsePillVo mapToPill(HPill pill, Boolean alreadyHave){
        return ResponsePillVo.builder()
                .pillId(pill.getPillId())
                .pillName(pill.getName())
                .manufacturer(pill.getManufacturer())
                .expirationAt(pill.getExpirationAt())
                .usageInstructions(pill.getUsageInstructions())
                .primaryFunctionality(pill.getPrimaryFunctionality())
                .precautions(pill.getPrecautions())
                .storageInstructions(pill.getStorageInstructions())
                .standardSpecification(pill.getStandardSpecification())
                .productForm(pill.getProductForm())
                .imageUrl(pill.getImageUrl())
                .takeCount(pill.getTakeCount())
                .takeCycle(pill.getTakeCycle())
                .nutrients(mapToResponsPillNutrientsListData(pill.getNutritions()))
                .categories(mapToResponsPillCategoryListData(pill.getPillCategories()))
                .alreadyHave(alreadyHave)
                .build();
    }
    public HPill mapToPillName(HPillVo vo) {
        return HPill.builder().name(vo.getPillName()).build();
    }

    public HNutrition mapToNutritionName(NutritionVo vo) {
        return HNutrition.builder().nutrition(vo.getNutrition()).build();
    }

    public Long mapToMidCategories(MidCategoryVo vo) {
        return vo.getCategories();
    }

    public ResponsePillSearchListData mapToResponsePillSearchListData(List<HPill> pillDetailList){

        List<ResponsePillSearchItem> items = new ArrayList<>();

        for (HPill pillDetail : pillDetailList) {
            items.add(mapToResponsePillSearchItem(pillDetail));
        }

        return ResponsePillSearchListData.builder().data(items).build();
    }
    private ResponsePillSearchItem mapToResponsePillSearchItem(HPill pillDetail){
        return ResponsePillSearchItem
                .builder()
                .pillId(pillDetail.getPillId())
                .pillName(pillDetail.getName())
                .manufacturer(pillDetail.getManufacturer())
                .imageUrl(pillDetail.getImageUrl())
                .build();
    }
    public ResponsePillNutrientsListData mapToResponsPillNutrientsListData(List<HNutrition> nutritions){

        List<ResponseNutrientsItem> items = new ArrayList<>();

        for (HNutrition nutrition : nutritions) {
            items.add(mapToResponsePillNutrientsItem(nutrition));
        }

        return ResponsePillNutrientsListData.builder().nutrientsItems(items).build();
    }
    private ResponseNutrientsItem mapToResponsePillNutrientsItem(HNutrition nutrition){

            return ResponseNutrientsItem.builder()
                    .nutritionId(nutrition.getNutritionId())
                    .nutrition(nutrition.getNutrition())
                    .amount(nutrition.getAmount())
                    .unit(nutrition.getUnit())
                    .includePercent(nutrition.getIncludePercent())
                    .build();

    }
    public ResponsePillCategoryListData mapToResponsPillCategoryListData(List<HPillCategory> categories){

        List<ResponsePillCategoryItem> items = new ArrayList<>();

        for (HPillCategory category : categories) {
            items.add(mapToResponsePillCategoryItem(category));
        }

        return ResponsePillCategoryListData.builder().pillCategoryItems(items).build();
    }
    private ResponsePillCategoryItem mapToResponsePillCategoryItem(HPillCategory category){

        return ResponsePillCategoryItem.builder()
                .mappingId(category.getMappingId())
                .midcategoryId(category.getMidCategory().getMidCategoryId())
                .midcategoryName((category.getMidCategory().getCategoryNm()))
                .build();

    }
}
