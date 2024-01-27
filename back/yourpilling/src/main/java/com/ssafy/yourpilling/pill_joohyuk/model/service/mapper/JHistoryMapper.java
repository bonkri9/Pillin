package com.ssafy.yourpilling.pill_joohyuk.model.service.mapper;

import com.ssafy.yourpilling.pill_joohyuk.model.dao.entity.JTakerHistory;
import com.ssafy.yourpilling.pill_joohyuk.model.service.vo.out.JResponseDailyHistoryVo;
import org.springframework.stereotype.Component;

@Component
public class JHistoryMapper {

    public JResponseDailyHistoryVo mapToResponseDailyHistoryVo(JTakerHistory takerHistory, boolean isTake) {
        return JResponseDailyHistoryVo.builder()
                .name(takerHistory.getOwnPill().getPill().getName())
                .takeYn(isTake)
                .actualTakeCount(takerHistory.getCurrentTakeCount())
                .needToTakeTotalCount(takerHistory.getNeedToTakeCount())
                .build();
    }
}
