package com.ssafy.yourpilling.takerhistory.model.service.impl;

import com.ssafy.yourpilling.takerhistory.model.dao.TakerHistoryDao;
import com.ssafy.yourpilling.takerhistory.model.dao.entity.TakerHistoryOwnPill;
import com.ssafy.yourpilling.takerhistory.model.dao.entity.TakerHistoryTakerHistory;
import com.ssafy.yourpilling.takerhistory.model.service.TakerHistoryService;
import com.ssafy.yourpilling.takerhistory.model.service.mapper.TakerHistoryServiceMapper;
import com.ssafy.yourpilling.takerhistory.model.service.mapper.value.TakerHistoryGenerateValue;
import com.ssafy.yourpilling.takerhistory.model.service.vo.in.DailyHistoryVo;
import com.ssafy.yourpilling.takerhistory.model.service.vo.out.OutDailyHistoryVo;
import com.ssafy.yourpilling.takerhistory.model.service.vo.out.wrapper.OutDailyHistoryVos;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;


@Service
@Slf4j
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class TakerHistoryServiceImpl implements TakerHistoryService {

    private final TakerHistoryDao takerHistoryDao;
    private final TakerHistoryServiceMapper mapper;

    @Scheduled(cron = "0 30/3 23-23 * * *")
    @Transactional
    @Override
    public void generateAllMemberTakerHistory() {
        log.info("[요청 : 복용 기록 생성 스케줄러 동작]");
        if(isTomorrow()) {
            return;
        }

        int tomorrow = (LocalDate.now().getDayOfWeek().getValue() % 7);
        List<TakerHistoryTakerHistory> takerHistories = new ArrayList<>();
        List<TakerHistoryOwnPill> needToTakeOwnPillsTomorrow = takerHistoryDao.findByTomorrow(1 << tomorrow);

        for (TakerHistoryOwnPill own : needToTakeOwnPillsTomorrow) {
            takerHistories.add(mapper.toTakerHistory(toTakerHistoryGenerateValue(own)));
        }

        log.info("[동작 : 복용 기록 {}개 생성]", takerHistories.size());
        takerHistoryDao.generateAllMemberTakerHistory(takerHistories);
    }

    @Override
    public OutDailyHistoryVos findByTakeAtAndMemberId(DailyHistoryVo dailyHistoryVo) {
        List<TakerHistoryTakerHistory> dailyHistories = takerHistoryDao.findByTakeAtAndMemberId(dailyHistoryVo.getTakeAt(), dailyHistoryVo.getMemberId());
        List<OutDailyHistoryVo> responses = new ArrayList<>();

        for (TakerHistoryTakerHistory dailyHistory : dailyHistories) {

            if(dailyHistory.isInvalid()) continue;

            boolean isTake = dailyHistory.getNeedToTakeCount().equals(dailyHistory.getCurrentTakeCount());

            responses.add(mapper.mapToResponseDailyHistoryVo(dailyHistory, isTake));
        }

        return new OutDailyHistoryVos(responses);

    }

    private static boolean isTomorrow() {
        return LocalDateTime.now().getHour() != 23;
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
