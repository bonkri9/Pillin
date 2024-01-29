package com.ssafy.yourpilling.push.model.service.vo;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class DeviceTokenVo {

    private Long memberId;
    private String deviceToken;

}
