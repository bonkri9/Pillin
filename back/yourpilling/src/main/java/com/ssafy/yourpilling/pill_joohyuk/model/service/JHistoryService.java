package com.ssafy.yourpilling.pill_joohyuk.model.service;

import com.ssafy.yourpilling.pill_joohyuk.model.service.vo.in.JDailyHistoryVo;
import com.ssafy.yourpilling.pill_joohyuk.model.service.vo.out.wrapper.JResponseDailyHistoryVos;

public interface JHistoryService {

    JResponseDailyHistoryVos findByTakeAtAndMemberId(JDailyHistoryVo dailyHistoryVo);

}
