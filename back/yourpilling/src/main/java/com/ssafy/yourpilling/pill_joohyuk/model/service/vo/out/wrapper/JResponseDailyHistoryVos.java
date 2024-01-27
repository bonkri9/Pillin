package com.ssafy.yourpilling.pill_joohyuk.model.service.vo.out.wrapper;

import com.ssafy.yourpilling.pill_joohyuk.model.service.vo.out.JResponseDailyHistoryVo;
import lombok.Value;

import java.util.List;

@Value
public class JResponseDailyHistoryVos {
    List<JResponseDailyHistoryVo> taken;
}
