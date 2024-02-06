package com.ssafy.yourpilling.pill.model.service.vo.in;

import com.ssafy.yourpilling.common.TakeWeekday;
import lombok.Builder;
import lombok.Data;
import lombok.Value;

import java.time.LocalDate;
import java.util.List;

@Value
@Builder
public class OwnPillUpdateVo {
    Long ownPillId;
    Integer remains;
    Integer totalCount;
    List<TakeWeekday> takeWeekdays;
    Integer takeCount;
    Integer takeOnceAmount;
    Boolean takeYn;
    LocalDate startAt;
}
