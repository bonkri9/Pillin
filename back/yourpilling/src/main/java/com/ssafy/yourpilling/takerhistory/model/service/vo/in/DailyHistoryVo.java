package com.ssafy.yourpilling.takerhistory.model.service.vo.in;

import lombok.Builder;
import lombok.Value;

import java.time.LocalDate;

@Value
@Builder
public class DailyHistoryVo {

    Long memberId;
    LocalDate takeAt;

}
