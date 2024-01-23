package com.ssafy.yourpilling.pill_heeju.controller.mapper;

import com.ssafy.yourpilling.pill_heeju.controller.dto.request.RequestPillDetailDto;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.PillDetailVo;
import org.springframework.stereotype.Component;

@Component
public class PillControllerMapper {
    public PillDetailVo mapToPillIdVo(RequestPillDetailDto dto){
        return PillDetailVo.builder().pillId(dto.getPillId()).build();
    }
}
