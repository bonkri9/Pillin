package com.ssafy.yourpilling.takerhistory.model.service.mapper.value;

import com.ssafy.yourpilling.takerhistory.model.dao.entity.TakerHistoryOwnPill;
import lombok.Builder;
import lombok.Value;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Value
@Builder
public class TakerHistoryGenerateValue {

    Integer needToTakeCount;
    Integer currentTakeCount;
    LocalDateTime createdAt;
    LocalDate takeAt;
    TakerHistoryOwnPill ownPill;
}
