package com.ssafy.yourpilling.takerhistory.model.service.mapper;

import com.ssafy.yourpilling.takerhistory.model.dao.entity.TakerHistoryTakerHistory;
import com.ssafy.yourpilling.takerhistory.model.service.mapper.value.TakerHistoryGenerateValue;
import com.ssafy.yourpilling.takerhistory.model.service.vo.out.OutDailyHistoryVo;
import org.springframework.stereotype.Component;

@Component
public class TakerHistoryServiceMapper {

    public TakerHistoryTakerHistory toTakerHistory(TakerHistoryGenerateValue value) {
        return TakerHistoryTakerHistory
                .builder()
                .takeAt(value.getTakeAt())
                .needToTakeCount(value.getNeedToTakeCount())
                .currentTakeCount(value.getCurrentTakeCount())
                .createdAt(value.getCreatedAt())
                .ownPill(value.getOwnPill())
                .build();
    }

    public OutDailyHistoryVo mapToResponseDailyHistoryVo(TakerHistoryTakerHistory takerHistory, boolean isTake) {
        return OutDailyHistoryVo.builder()
                .ownPillId(takerHistory.getOwnPill().getOwnPillId())
                .name(takerHistory.getOwnPill().getPill().getName())
                .takeYn(isTake)
                .actualTakeCount(takerHistory.getCurrentTakeCount())
                .needToTakeTotalCount(takerHistory.getNeedToTakeCount())
                .takeCount(takerHistory.getOwnPill().getTakeCount())
                .build();
    }
}
