package com.ssafy.yourpilling.pill_joohyuk.controller.mapper;


import com.ssafy.yourpilling.pill_joohyuk.controller.dto.request.RequestDailyHistoryDto;
import com.ssafy.yourpilling.pill_joohyuk.model.service.vo.in.JDailyHistoryVo;
import org.springframework.stereotype.Component;

@Component
public class HistoryControllerMapper {
    public JDailyHistoryVo mapToMemberRegisterVo(RequestDailyHistoryDto dto, Long memberId) {
        return JDailyHistoryVo
                .builder()
                .memberId(memberId)
                .takeAt(dto.getDate())
                .build();
    }
}
