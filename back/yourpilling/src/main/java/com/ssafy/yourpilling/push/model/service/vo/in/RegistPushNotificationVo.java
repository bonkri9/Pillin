package com.ssafy.yourpilling.push.model.service.vo.in;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class RegistPushNotificationVo {

    int hour;
    int minute;
    Boolean[] day;
    String message;
    Long ownPillId;

}
