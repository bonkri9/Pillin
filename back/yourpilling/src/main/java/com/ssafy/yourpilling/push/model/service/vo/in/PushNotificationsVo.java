package com.ssafy.yourpilling.push.model.service.vo.in;


import lombok.Builder;
import lombok.Value;

import java.time.LocalDateTime;

@Value
@Builder
public class PushNotificationsVo {

    Byte pushDay;
    LocalDateTime pushTime;

}
