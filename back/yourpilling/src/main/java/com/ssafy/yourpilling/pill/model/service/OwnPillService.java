package com.ssafy.yourpilling.pill.model.service;

import com.ssafy.yourpilling.pill.model.service.vo.in.*;
import com.ssafy.yourpilling.pill.model.service.vo.out.*;


public interface OwnPillService {

    void register(OwnPillRegisterVo vo);

    OutOwnPillInventorListVo inventoryList(OwnPillInventoryListVo vo);

    OutOwnPillDetailVo detail(OwnPillDetailVo vo);

    void update(OwnPillUpdateVo vo);

    void remove(OwnPillRemoveVo vo);

    OutOwnPillTakeVo take(OwnPillTakeVo ownPillTakeVo);

    void takeAll(Long memberId);

    OutWeeklyTakerHistoryVo weeklyTakerHistory(WeeklyTakerHistoryVo weeklyTakerHistoryVo);

    OutMonthlyTakerHistoryVo monthlyTakerHistory(MonthlyTakerHistoryVo monthlyTakerHistoryVo);

    void updateTakeYn(OwnPillTakeYnVo ownPillTakeYnVo);

    void buyRecord(BuyRecordVo vo);
}
