package com.ssafy.yourpilling.rank.model.service.vo;

import com.ssafy.yourpilling.pill.model.dao.entity.BigCategory;
import lombok.Builder;
import lombok.Value;

import java.util.List;

@Value
@Builder
public class CategoryBigCategoryVo {

    Long bigCategoryId;
    String bigCategoryName;
    List<CategoryMidCategoryVo> midCategories;

    @Value
    @Builder
    public static class CategoryMidCategoryVo {
        Long midCategoryId;
        String midCategoryName;
    }
}
