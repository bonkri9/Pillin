package com.ssafy.yourpilling.takerhistory.model.service.vo.out.wrapper;

import com.ssafy.yourpilling.takerhistory.model.service.vo.out.OutDailyHistoryVo;
import lombok.Value;

import java.util.List;

@Value
public class OutDailyHistoryVos {
    List<OutDailyHistoryVo> taken;
}
