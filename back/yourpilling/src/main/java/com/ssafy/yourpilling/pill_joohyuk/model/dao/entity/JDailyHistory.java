package com.ssafy.yourpilling.pill_joohyuk.model.dao.entity;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class JDailyHistory {
    int needToTakeCount;
    int currentTakeCount;
    String pillName;
}
