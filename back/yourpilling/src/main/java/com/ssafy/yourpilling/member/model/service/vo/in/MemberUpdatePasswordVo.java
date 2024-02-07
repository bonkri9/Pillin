package com.ssafy.yourpilling.member.model.service.vo.in;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class MemberUpdatePasswordVo {
    Long memberId;
    String password;
}
