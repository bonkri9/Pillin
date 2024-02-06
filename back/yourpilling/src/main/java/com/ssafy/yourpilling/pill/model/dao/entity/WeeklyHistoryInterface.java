package com.ssafy.yourpilling.pill.model.dao.entity;

import java.time.LocalDate;

public interface WeeklyHistoryInterface {
    LocalDate getDate();
    Integer getNeedToTakenCountToday();
    Integer getActualTakenToday();

}
