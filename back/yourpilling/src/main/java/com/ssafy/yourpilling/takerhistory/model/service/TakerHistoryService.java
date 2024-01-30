package com.ssafy.yourpilling.takerhistory.model.service;

import com.ssafy.yourpilling.takerhistory.model.service.vo.in.DailyHistoryVo;
import com.ssafy.yourpilling.takerhistory.model.service.vo.out.wrapper.OutDailyHistoryVos;

public interface TakerHistoryService {

    void generateAllMemberTakerHistory();

    OutDailyHistoryVos findByTakeAtAndMemberId(DailyHistoryVo vo);
}
