package com.ssafy.yourpilling.push.model.service.vo.in;


import lombok.Builder;
import lombok.Value;


@Value
@Builder
public class PushNotificationVo {

    int pushDay;
    int hour;
    int minute;

}
