package com.ssafy.yourpilling.pill.controller.dto.request;

import com.ssafy.yourpilling.common.TakeWeekday;
import lombok.Data;

import java.time.LocalDate;
import java.util.List;

@Data
public class RequestOwnRegisterPillDto {
    private Long pillId;
    private Boolean takeYn;
    private Integer remains;
    private Integer totalCount;
    private List<TakeWeekday> takeWeekdays;
}

