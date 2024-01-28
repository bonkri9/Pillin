package com.ssafy.yourpilling.pill_heeju.controller.mapper;

import com.ssafy.yourpilling.pill_heeju.model.service.vo.MidCategoryVo;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.NutritionVo;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.PillDetailVo;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class HPillControllerMapper {
    public PillDetailVo mapToPillIdVo(Long pillId){
        return PillDetailVo.builder().pillId(pillId).build();
    }
    public PillDetailVo mapToPillNameVo(String pillName) {
        return PillDetailVo.builder().pillName(pillName).build();
    }
    public NutritionVo mapToNutritionIdVo(String nutritionName) {
        return NutritionVo.builder().nutrition(nutritionName).build();
    }
    public MidCategoryVo mapToCategoryVo(List<Integer> categories) {
        return MidCategoryVo.builder().categories(categories).build();
    }
}
