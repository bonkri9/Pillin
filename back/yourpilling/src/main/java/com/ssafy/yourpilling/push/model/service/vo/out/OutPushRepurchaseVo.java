package com.ssafy.yourpilling.push.model.service.vo.out;

import lombok.Builder;
import lombok.Value;

import java.util.List;

@Builder
@Value
public class OutPushRepurchaseVo {

    List<PushMemberVo> pushMemberVoList;
}
