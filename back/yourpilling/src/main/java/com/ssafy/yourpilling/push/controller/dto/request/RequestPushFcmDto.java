package com.ssafy.yourpilling.push.controller.dto.request;


import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class RequestPushFcmDto {

    private int pushDay;
    private int hour;
    private int minute;

}
