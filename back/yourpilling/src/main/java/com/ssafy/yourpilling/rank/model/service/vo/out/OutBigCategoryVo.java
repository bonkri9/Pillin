package com.ssafy.yourpilling.rank.model.service.vo.out;

import lombok.Builder;
import lombok.Value;

import java.util.List;

@Value
@Builder
public class OutBigCategoryVo {

    Long bigCategoryId;
    String bigCategoryName;
    List<OutMidCategoryVo> midCategories;

    @Value
    @Builder
    public static class OutMidCategoryVo {
        Long midCategoryId;
        String midCategoryName;
    }
}
