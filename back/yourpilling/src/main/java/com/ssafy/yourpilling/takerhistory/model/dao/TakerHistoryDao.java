package com.ssafy.yourpilling.takerhistory.model.dao;

import com.ssafy.yourpilling.takerhistory.model.dao.entity.TakerHistoryTakerHistory;
import com.ssafy.yourpilling.takerhistory.model.dao.entity.TakerHistoryOwnPill;

import java.time.LocalDate;
import java.util.List;

public interface TakerHistoryDao {

    List<TakerHistoryOwnPill> findByTomorrow(int tomorrow);

    void generateAllMemberTakerHistory(List<TakerHistoryTakerHistory> takerHistories);

    List<TakerHistoryTakerHistory> findByTakeAtAndMemberId(LocalDate takeAt, Long ownPillId);
}
