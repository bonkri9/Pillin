package com.ssafy.yourpilling.takerhistory.model.dao.impl;

import com.ssafy.yourpilling.takerhistory.model.dao.TakerHistoryDao;
import com.ssafy.yourpilling.takerhistory.model.dao.entity.TakerHistoryTakerHistory;
import com.ssafy.yourpilling.takerhistory.model.dao.entity.TakerHistoryOwnPill;
import com.ssafy.yourpilling.takerhistory.model.dao.jpa.TakerHistoryOwnPillRepository;
import com.ssafy.yourpilling.takerhistory.model.dao.jpa.TakerHistoryTakerHistoryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class TakerHistoryDaoImpl implements TakerHistoryDao {

    private final TakerHistoryOwnPillRepository takerHistoryOwnPillRepository;
    private final TakerHistoryTakerHistoryRepository takerHistoryRepository;

    @Override
    public List<TakerHistoryOwnPill> findByTomorrow(int tomorrow) {
        return takerHistoryOwnPillRepository.findByTakeYnTrueAndTakeWeekdaysBitwiseAnd(tomorrow);
    }

    @Override
    public void generateAllMemberTakerHistory(List<TakerHistoryTakerHistory> takerHistories) {
        for (TakerHistoryTakerHistory history : takerHistories) {
            if(takerHistoryRepository.findByTakeAtAndOwnPillOwnPillId(history.getTakeAt(),
                    history.getOwnPill().getOwnPillId()).isEmpty()){
                takerHistoryRepository.save(history);
            }
        }
    }
}
