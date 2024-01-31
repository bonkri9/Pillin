package com.ssafy.yourpilling.pill.model.service.vo.in;

import lombok.Builder;
import lombok.Value;

import java.time.LocalDate;

@Value
@Builder
public class MonthlyTakerHistoryVo {

    LocalDate date;
    Long memberId;

}
