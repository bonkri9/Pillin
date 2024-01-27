package com.ssafy.yourpilling.pill_joohyuk.model.service.vo.in;

import lombok.Builder;
import lombok.Value;

import java.time.LocalDate;

@Value
@Builder
public class JDailyHistoryVo {

    Long memberId;
    LocalDate takeAt;

}
