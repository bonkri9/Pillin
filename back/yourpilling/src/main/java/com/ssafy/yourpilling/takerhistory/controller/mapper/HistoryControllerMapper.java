package com.ssafy.yourpilling.takerhistory.controller.mapper;


import com.ssafy.yourpilling.takerhistory.controller.dto.request.RequestDailyHistoryDto;
import com.ssafy.yourpilling.takerhistory.model.service.vo.in.DailyHistoryVo;
import org.springframework.stereotype.Component;

import java.time.LocalDate;

@Component
public class HistoryControllerMapper {
    public DailyHistoryVo mapToMemberRegisterVo(LocalDate date, Long memberId) {
        return DailyHistoryVo
                .builder()
                .memberId(memberId)
                .takeAt(date)
                .build();
    }
}
