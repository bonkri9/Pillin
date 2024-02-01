package com.ssafy.yourpilling.pill.model.service.mapper.value;

import com.ssafy.yourpilling.pill.model.dao.entity.Pill;
import com.ssafy.yourpilling.pill.model.dao.entity.PillMember;
import com.ssafy.yourpilling.pill.model.service.vo.in.OwnPillRegisterVo;
import lombok.Builder;
import lombok.Value;

import java.time.LocalDateTime;

@Value
@Builder
public class OwnPillRegisterValue {
    OwnPillRegisterVo vo;
    int adjustRemain;
    boolean adjustIsTaken;
    PillMember member;
    Pill pill;
    boolean isAlarm;
    LocalDateTime createAt;
    Integer takeWeekDaysValue;
    Integer takeOnceAmount;
}
