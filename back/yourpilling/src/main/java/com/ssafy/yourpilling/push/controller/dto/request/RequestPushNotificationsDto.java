package com.ssafy.yourpilling.push.controller.dto.request;

import lombok.Data;

@Data
public class RequestPushNotificationsDto {

    Long ownPillId;
    String ownPillName;
    Boolean[] day;
    int hour;
    int minute;

}
