package com.ssafy.yourpilling.takerhistory.model.service.impl;

import com.ssafy.yourpilling.takerhistory.model.dao.TakerHistoryDao;
import com.ssafy.yourpilling.takerhistory.model.dao.entity.TakerHistory;
import com.ssafy.yourpilling.takerhistory.model.dao.entity.TakerHistoryOwnPill;
import com.ssafy.yourpilling.takerhistory.model.service.TakerHistoryService;
import com.ssafy.yourpilling.takerhistory.model.service.mapper.TakerHistoryServiceMapper;
import com.ssafy.yourpilling.takerhistory.model.service.mapper.value.TakerHistoryGenerateValue;
import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;


@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class TakerHistoryServiceImpl implements TakerHistoryService {

    private final TakerHistoryDao takerHistoryDao;
    private final TakerHistoryServiceMapper mapper;

    @Scheduled(cron = "30 50,53,56 23 * * *")
    @Transactional
    @Override
    public void generateAllMemberTakerHistory() {
        if(isTomorrow()) {
            return;
        }

        int tomorrow = (LocalDate.now().getDayOfWeek().getValue() % 7);
        List<TakerHistory> takerHistories = new ArrayList<>();
        List<TakerHistoryOwnPill> needToTakeOwnPillsTomorrow = takerHistoryDao.findByTomorrow(1 << tomorrow);

        for (TakerHistoryOwnPill own : needToTakeOwnPillsTomorrow) {
            takerHistories.add(mapper.toTakerHistory(toTakerHistoryGenerateValue(own)));
        }

        takerHistoryDao.generateAllMemberTakerHistory(takerHistories);
    }

    private static boolean isTomorrow() {
        return LocalDateTime.now().getHour() == 0;
    }

    private TakerHistoryGenerateValue toTakerHistoryGenerateValue(TakerHistoryOwnPill own){
        return TakerHistoryGenerateValue
                .builder()
                .needToTakeCount(own.getTakeCount() * own.getTakeOnceAmount())
                .currentTakeCount(0)
                .createdAt(LocalDateTime.now())
                .takeAt(LocalDate.now().plusDays(1))
                .ownPill(own)
                .build();
    }
}
