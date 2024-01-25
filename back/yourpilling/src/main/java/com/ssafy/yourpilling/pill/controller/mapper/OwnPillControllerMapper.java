package com.ssafy.yourpilling.pill.controller.mapper;

import com.ssafy.yourpilling.pill.controller.dto.request.RequestOwnPillUpdateDto;
import com.ssafy.yourpilling.pill.controller.dto.request.RequestOwnPillDetailDto;
import com.ssafy.yourpilling.pill.controller.dto.request.RequestOwnRegisterPillDto;
import com.ssafy.yourpilling.pill.model.service.vo.in.OwnPillUpdateVo;
import com.ssafy.yourpilling.pill.model.service.vo.in.OwnPillDetailVo;
import com.ssafy.yourpilling.pill.model.service.vo.in.OwnPillInventoryListVo;
import com.ssafy.yourpilling.pill.model.service.vo.in.OwnPillRegisterVo;
import org.springframework.stereotype.Component;

@Component
public class OwnPillControllerMapper {

    public OwnPillDetailVo mapToPillDetailVo(RequestOwnPillDetailDto dto){
        return OwnPillDetailVo
                .builder()
                .ownPillId(dto.getOwnPillId())
                .build();
    }

    public OwnPillRegisterVo mapToPillRegisterVo(Long memberId, RequestOwnRegisterPillDto dto){
        return OwnPillRegisterVo
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

    public OwnPillInventoryListVo mapToPillInventoryListVo(Long memberId){
        return OwnPillInventoryListVo
                .builder()
                .memberId(memberId)
                .build();
    }
}
