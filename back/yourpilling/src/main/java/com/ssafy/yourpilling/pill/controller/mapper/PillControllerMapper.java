package com.ssafy.yourpilling.pill.controller.mapper;

import com.ssafy.yourpilling.pill.controller.dto.request.RequestOwnPillUpdateDto;
import com.ssafy.yourpilling.pill.controller.dto.request.RequestPillDetailDto;
import com.ssafy.yourpilling.pill.controller.dto.request.RequestRegisterPillDto;
import com.ssafy.yourpilling.pill.model.service.vo.in.OwnPillUpdateVo;
import com.ssafy.yourpilling.pill.model.service.vo.in.PillDetailVo;
import com.ssafy.yourpilling.pill.model.service.vo.in.PillInventoryListVo;
import com.ssafy.yourpilling.pill.model.service.vo.in.PillRegisterVo;
import org.springframework.stereotype.Component;

@Component
public class PillControllerMapper {

    public PillDetailVo mapToPillDetailVo(RequestPillDetailDto dto){
        return PillDetailVo
                .builder()
                .ownPillId(dto.getOwnPillId())
                .build();
    }

    public PillRegisterVo mapToPillRegisterVo(Long memberId, RequestRegisterPillDto dto){
        return PillRegisterVo
                .builder()
                .pillId(dto.getPillId())
                .memberId(memberId)
                .startAt(dto.getStartAt())
                .takeYn(dto.getTakeYn())
                .remains(dto.getRemains())
                .totalCount(dto.getTotalCount())
                .takeWeekdays(dto.getTakeWeekdays())
                .takeCount(dto.getTakeCount())
                .takeOnceAmount(dto.getTakeOnceAmount())
                .build();
    }

    public OwnPillUpdateVo mapToOwnPillUpdateVo(RequestOwnPillUpdateDto dto){
        return OwnPillUpdateVo
                .builder()
                .ownPillId(dto.getOwnPillId())
                .remains(dto.getRemains())
                .totalCount(dto.getTotalCount())
                .takeWeekdays(dto.getTakeWeekdays())
                .takeCount(dto.getTakeCount())
                .takeOnceAmount(dto.getTakeOnceAmount())
                .takeYn(dto.getTakeYn())
                .startAt(dto.getStartAt())
                .build();
    }

    public PillInventoryListVo mapToPillInventoryListVo(Long memberId){
        return PillInventoryListVo
                .builder()
                .memberId(memberId)
                .build();
    }
}
