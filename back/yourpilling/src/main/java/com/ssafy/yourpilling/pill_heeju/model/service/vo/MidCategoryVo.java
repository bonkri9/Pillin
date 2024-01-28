package com.ssafy.yourpilling.pill_heeju.model.service.vo;

import lombok.Builder;
import lombok.Value;

import java.util.List;
@Value
@Builder
public class MidCategoryVo {
    List<Integer> categories;
}
