package com.ssafy.yourpilling.takerhistory.model.dao.impl;

import com.ssafy.yourpilling.takerhistory.model.dao.TakerHistoryDao;
import com.ssafy.yourpilling.takerhistory.model.dao.entity.TakerHistory;
import com.ssafy.yourpilling.takerhistory.model.dao.entity.TakerHistoryOwnPill;
import com.ssafy.yourpilling.takerhistory.model.dao.jpa.TakerHistoryOwnPillRepository;
import com.ssafy.yourpilling.takerhistory.model.dao.jpa.TakerHistoryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class TakerHistoryDaoImpl implements TakerHistoryDao {

    private final TakerHistoryOwnPillRepository takerHistoryOwnPillRepository;
    private final TakerHistoryRepository takerHistoryRepository;

    @Override
    public List<TakerHistoryOwnPill> findByTomorrow(int tomorrow) {
        return takerHistoryOwnPillRepository.findByTakeYnTrueAndTakeWeekdaysBitwiseAnd(tomorrow);
    }

    @Override
    public void generateAllMemberTakerHistory(List<TakerHistory> takerHistories) {
        for (TakerHistory history : takerHistories) {
            if(takerHistoryRepository.findByTakeAtAndOwnPillOwnPillId(history.getTakeAt(),
                    history.getOwnPill().getOwnPillId()).isEmpty()){
                takerHistoryRepository.save(history);
            }
        }
    }
}
