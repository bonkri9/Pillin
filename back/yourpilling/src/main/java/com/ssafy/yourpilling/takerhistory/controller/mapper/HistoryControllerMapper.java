package com.ssafy.yourpilling.takerhistory.controller.mapper;


import com.ssafy.yourpilling.takerhistory.controller.dto.request.RequestDailyHistoryDto;
import com.ssafy.yourpilling.takerhistory.model.service.vo.in.DailyHistoryVo;
import org.springframework.stereotype.Component;

@Component
public class HistoryControllerMapper {
    public DailyHistoryVo mapToMemberRegisterVo(RequestDailyHistoryDto dto, Long memberId) {
        return DailyHistoryVo
                .builder()
                .memberId(memberId)
                .takeAt(dto.getDate())
                .build();
    }
}
