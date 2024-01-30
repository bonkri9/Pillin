package com.ssafy.yourpilling.takerhistory.model.service.vo.out;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class OutDailyHistoryVo {
    String name;
    int actualTakeCount;
    int needToTakeTotalCount;
    boolean takeYn;
}
