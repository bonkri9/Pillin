package com.ssafy.yourpilling.pill_joohyuk.model.dao;

import com.ssafy.yourpilling.pill_joohyuk.model.dao.entity.JTakerHistory;

import java.time.LocalDate;
import java.util.List;

public interface JHistoryDao {

    List<JTakerHistory> findByTakeAtAndMemberId(LocalDate takeAt, Long ownPillId);

}
