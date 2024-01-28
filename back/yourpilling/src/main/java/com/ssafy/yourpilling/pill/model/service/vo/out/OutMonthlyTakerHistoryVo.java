package com.ssafy.yourpilling.pill.model.service.vo.out;

import com.ssafy.yourpilling.pill.model.service.dto.TakerHistorySummary;
import lombok.Builder;
import lombok.Value;

import java.time.LocalDate;
import java.util.HashMap;

@Value
@Builder
public class OutMonthlyTakerHistoryVo {

    HashMap<LocalDate, TakerHistorySummary> data;
}
