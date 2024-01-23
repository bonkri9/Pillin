package com.ssafy.yourpilling.pill.controller.mapper;

import com.ssafy.yourpilling.pill.controller.dto.request.RequestRegisterPillDto;
import com.ssafy.yourpilling.pill.model.service.vo.PillRegisterVo;
import org.springframework.stereotype.Component;

@Component
public class PillControllerMapper {

    public PillRegisterVo mapToPillRegisterVo(Long memberId, RequestRegisterPillDto dto){
        return PillRegisterVo
                .builder()
                .pillId(dto.getPillId())
                .memberId(memberId)
                .startAt(dto.getStartAt())
                .takeYn(dto.getTakeYn())
                .remains(dto.getRemains())
                .totalCount(dto.getTotalCount())
                .takeCount(dto.getTakeCount())
                .build();
    }
}
