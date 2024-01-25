package com.ssafy.yourpilling.pill.model.service.mapper.value;

import com.ssafy.yourpilling.pill.model.dao.entity.Pill;
import com.ssafy.yourpilling.pill.model.dao.entity.PillMember;
import com.ssafy.yourpilling.pill.model.service.vo.in.PillRegisterVo;
import lombok.Builder;
import lombok.Value;

import java.time.LocalDateTime;

import static java.time.LocalDateTime.now;

@Value
@Builder
public class OwnPillRegisterValue {
    PillRegisterVo vo;
    PillMember member;
    Pill pill;
    boolean isAlarm;
    LocalDateTime createAt;
    Integer takeWeekDaysValue;
    Integer takeOnceAmount;
}
