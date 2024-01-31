package com.ssafy.yourpilling.push.controller.dto.request;

import lombok.Data;

@Data
public class RequestUpdatePushNotificationDto {

    Long pushId;
    Boolean[] day;
    int hour;
    int minute;


}
