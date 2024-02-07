package com.ssafy.yourpilling.rank.model.service.vo.out.wrap;

import com.ssafy.yourpilling.rank.model.service.vo.out.OutBigCategoryVo;
import lombok.Builder;
import lombok.Value;

import java.util.List;

@Value
@Builder
public class OutCategoryVos {

    List<OutBigCategoryVo> categoires;

}
