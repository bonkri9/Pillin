package com.ssafy.yourpilling.takerhistory.model.service.vo.out;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class OutDailyHistoryVo {
    Long ownPillId;
    String name;
    int actualTakeCount;
    int needToTakeTotalCount;
    int takeCount;
    int remains;
    boolean takeYn;
}
