package com.ssafy.yourpilling.pill.controller.mapper;

import com.ssafy.yourpilling.pill.controller.dto.request.*;
import com.ssafy.yourpilling.pill.model.service.vo.in.*;
import org.springframework.stereotype.Component;

import java.time.LocalDate;

@Component
public class OwnPillControllerMapper {

    public OwnPillDetailVo mapToPillDetailVo(Long ownPillId){
        return OwnPillDetailVo
                .builder()
                .ownPillId(ownPillId)
                .build();
    }

    public OwnPillRegisterVo mapToPillRegisterVo(Long memberId, RequestOwnRegisterPillDto dto){
        return OwnPillRegisterVo
                .builder()
                .pillId(dto.getPillId())
                .memberId(memberId)
                .takeYn(dto.getTakeYn())
                .remains(dto.getRemains())
                .totalCount(dto.getTotalCount())
                .takeWeekdays(dto.getTakeWeekdays())
                .build();
    }

    public OwnPillUpdateVo mapToOwnPillUpdateVo(RequestOwnPillUpdateDto dto){
        return OwnPillUpdateVo
                .builder()
                .ownPillId(dto.getOwnPillId())
                .remains(dto.getRemains())
                .totalCount(dto.getTotalCount())
                .build();
    }

    public OwnPillInventoryListVo mapToPillInventoryListVo(Long memberId){
        return OwnPillInventoryListVo
                .builder()
                .memberId(memberId)
                .build();
    }

    public OwnPillRemoveVo mapToOwnPillRemoveVo(RequestOwnPillRemoveDto dto) {
        return OwnPillRemoveVo
                .builder()
                .ownPillId(dto.getOwnPillId())
                .build();
    }

    public OwnPillTakeVo mapToOwnPillTakeVo(RequestOwnPillTakeDto dto) {

        return OwnPillTakeVo.
                builder()
                .ownPillId(dto.getOwnPillId())
                .build();

    }

    public OwnPillTakeYnVo mapToOwnPillTakeYnVo(RequestOwnPillTakeYnDto dto) {

        return OwnPillTakeYnVo.
                builder()
                .ownPillId(dto.getOwnPillId())
                .build();

    }

    public WeeklyTakerHistoryVo mapToWeeklyTakerHistoryVo(Long memberId, LocalDate now) {

        return  WeeklyTakerHistoryVo.
                builder()
                .memberId(memberId)
                .date(now)
                .build();

    }

    public MonthlyTakerHistoryVo mapToMonthlyTakerHistoryVo(Long memberId, LocalDate date) {
        return MonthlyTakerHistoryVo
                .builder()
                .memberId(memberId)
                .date(date)
                .build();
    }

    public BuyRecordVo mapToBuyRecordVo(Long memberId, RequestPillBuyRecordDto dto) {
        return BuyRecordVo
                .builder()
                .memberId(memberId)
                .pillId(dto.getPillId())
                .build();
    }
}
