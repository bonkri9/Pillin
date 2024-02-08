package com.ssafy.yourpilling.push.model.service.vo.out;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class OutDeviceTokenVo {
    Long tokenId;
    String deviceToken;
}
