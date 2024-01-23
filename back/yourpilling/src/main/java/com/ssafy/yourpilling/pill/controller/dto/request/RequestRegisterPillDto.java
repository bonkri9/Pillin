package com.ssafy.yourpilling.pill.controller.dto.request;

import lombok.Data;

import java.time.LocalDate;

@Data
public class RequestRegisterPillDto {
    private Long pillId;
    private LocalDate startAt;
    private Boolean takeYn;
    private Integer remains;
    private Integer totalCount;
    private Integer takeCount;
}

