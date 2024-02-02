package com.ssafy.yourpilling.push.model.service.vo.in;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class UpdatePushNotificationVo {

    int hour;
    int minute;
    Boolean[] day;
    Long memberId;
    Long pushId;

}
