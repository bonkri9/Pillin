package com.ssafy.yourpilling.pill_heeju.controller.mapper;

import com.ssafy.yourpilling.pill_heeju.model.service.vo.MidCategoryVo;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.NutritionVo;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.HPillVo;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class HPillControllerMapper {
    public HPillVo mapToPillIdVo(Long memberId, Long pillId){
        return HPillVo
                .builder()
                .memberId(memberId)
                .pillId(pillId)
                .build();
    }
    public HPillVo mapToPillNameVo(String pillName) {
        return HPillVo.builder().pillName(pillName).build();
    }
    public NutritionVo mapToNutritionIdVo(String nutritionName) {
        return NutritionVo.builder().nutrition(nutritionName).build();
    }
    public MidCategoryVo mapToCategoryVo(Long categories) {
        return MidCategoryVo.builder().categories(categories).build();
    }
}
