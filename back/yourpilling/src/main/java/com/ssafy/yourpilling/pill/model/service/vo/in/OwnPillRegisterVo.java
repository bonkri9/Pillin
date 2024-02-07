package com.ssafy.yourpilling.pill.model.service.vo.in;

import com.ssafy.yourpilling.common.TakeWeekday;
import lombok.Builder;
import lombok.Value;

import java.time.LocalDate;
import java.util.List;

@Value
@Builder
public class OwnPillRegisterVo {
    Long pillId;
    Long memberId;
    Boolean takeYn;
    Integer remains;
    Integer totalCount;
    List<TakeWeekday> takeWeekdays;
}
