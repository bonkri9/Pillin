package com.ssafy.yourpilling.rank.model.service.vo.wrap;

import com.ssafy.yourpilling.rank.model.service.vo.CategoryBigCategoryVo;
import lombok.Builder;
import lombok.Value;

import java.util.List;

@Value
@Builder
public class CategoryCategoryVos {

    List<CategoryBigCategoryVo> categoires;

}
