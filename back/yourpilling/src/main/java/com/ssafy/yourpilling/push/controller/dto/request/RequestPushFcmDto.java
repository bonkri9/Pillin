package com.ssafy.yourpilling.push.controller.dto.request;


import lombok.Data;

@Data
public class RequestPushFcmDto {

    private Byte pushDay;
    private int hour;
    private int minute;

}
