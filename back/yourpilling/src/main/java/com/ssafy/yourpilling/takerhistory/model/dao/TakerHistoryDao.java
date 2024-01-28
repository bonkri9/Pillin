package com.ssafy.yourpilling.takerhistory.model.dao;

import com.ssafy.yourpilling.takerhistory.model.dao.entity.TakerHistory;
import com.ssafy.yourpilling.takerhistory.model.dao.entity.TakerHistoryOwnPill;

import java.util.List;

public interface TakerHistoryDao {

    List<TakerHistoryOwnPill> findByTomorrow(int tomorrow);

    void generateAllMemberTakerHistory(List<TakerHistory> takerHistories);
}
