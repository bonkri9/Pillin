package com.ssafy.yourpilling.push.model.service.vo.out;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class OutPushMessageInfoVo {

    String ownPillName;
    Long pushId;
    Boolean[] days;
    int hour;
    int minute;

}
