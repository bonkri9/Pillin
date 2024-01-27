package com.ssafy.yourpilling.pill_joohyuk.model.service.vo.out;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class JResponseDailyHistoryVo {
    String name;
    int actualTakeCount;
    int needToTakeTotalCount;
    boolean takeYn;
}
