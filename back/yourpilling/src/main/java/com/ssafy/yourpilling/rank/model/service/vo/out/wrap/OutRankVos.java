package com.ssafy.yourpilling.rank.model.service.vo.out.wrap;

import com.ssafy.yourpilling.rank.model.service.vo.out.OutRankVo;
import lombok.Builder;
import lombok.ToString;
import lombok.Value;

import java.util.List;

@Value
@Builder
@ToString
public class OutRankVos {
    List<OutRankVo> data;
}
