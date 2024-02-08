package com.ssafy.yourpilling.push.model.service.vo.out;

import lombok.Builder;
import lombok.Value;

import java.util.List;

@Value
@Builder
public class PushMemberVo {

    Long memberId;
    List<OutDeviceTokenVo> deviceTokenVos;
    List<PushOwnPillVo> ownPillVos;

}
