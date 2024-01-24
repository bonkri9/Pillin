package com.ssafy.yourpilling.pill.model.service.vo;

import lombok.Builder;
import lombok.Value;

import java.time.LocalDate;

@Value
@Builder
public class PillRegisterVo {
    Long pillId;
    Long memberId;
    LocalDate startAt;
    Boolean takeYn;
    Integer remains;
    Integer totalCount;
    Integer takeCount;
}
