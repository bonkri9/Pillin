package com.ssafy.yourpilling.push.controller.dto.request;


import lombok.Data;

import java.time.LocalDateTime;

@Data
public class RequestPushMessageDto {

    private Byte pushDay;
    private LocalDateTime pushTime;

}
