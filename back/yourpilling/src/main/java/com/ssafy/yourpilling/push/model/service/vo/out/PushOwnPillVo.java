package com.ssafy.yourpilling.push.model.service.vo.out;


import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class PushOwnPillVo {

    Long ownPillId;
    Boolean takeYN;
    int remains;
    int totalCount;
    PushMemberVo member;
}
