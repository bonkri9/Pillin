package com.ssafy.yourpilling.pill.model.service.vo.in;

import com.ssafy.yourpilling.common.TakeWeekday;
import lombok.Builder;
import lombok.Value;

import java.time.LocalDate;
import java.util.List;

@Value
@Builder
public class PillRegisterVo {
    Long pillId;
    Long memberId;
    LocalDate startAt;
    Boolean takeYn;
    Integer remains;
    Integer totalCount;
    List<TakeWeekday> takeWeekdays;
    Integer takeCount;
    Integer takeOnceAmount;
}
