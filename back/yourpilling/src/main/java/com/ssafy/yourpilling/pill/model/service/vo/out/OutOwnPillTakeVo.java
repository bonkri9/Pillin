package com.ssafy.yourpilling.pill.model.service.vo.out;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class OutOwnPillTakeVo {

    Boolean needToUpdateWeeklyHistory;

}
