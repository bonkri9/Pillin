package com.ssafy.yourpilling.push.model.service.vo.out;

import lombok.Builder;
import lombok.Value;

import java.util.HashMap;
import java.util.List;

@Value
@Builder
public class OutPushMessageInfoMapVo {
    List<HashMap<Long, OutPushMessageInfoVo>> data;
}
