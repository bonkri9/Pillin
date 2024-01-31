package com.ssafy.yourpilling.pill.controller.dto.request;

import com.ssafy.yourpilling.common.TakeWeekday;
import lombok.Data;

import java.time.LocalDate;
import java.util.List;

@Data
public class RequestOwnPillUpdateDto {
    Long ownPillId;
    Integer remains;
    Integer totalCount;
    List<TakeWeekday> takeWeekdays;
    Integer takeCount;
    Integer takeOnceAmount;
    Boolean takeYn;
    LocalDate startAt;
}
