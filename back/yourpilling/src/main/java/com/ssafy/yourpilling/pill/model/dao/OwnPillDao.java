package com.ssafy.yourpilling.pill.model.dao;

import com.ssafy.yourpilling.pill.model.dao.entity.MonthlyTakerHistory;
import com.ssafy.yourpilling.pill.model.dao.entity.OwnPill;
import com.ssafy.yourpilling.pill.model.dao.entity.Pill;
import com.ssafy.yourpilling.pill.model.dao.entity.PillMember;
import com.ssafy.yourpilling.pill.model.service.vo.in.MonthlyTakerHistoryVo;
import com.ssafy.yourpilling.pill.model.service.vo.in.OwnPillUpdateVo;
import com.ssafy.yourpilling.pill.model.service.vo.in.WeeklyTakerHistoryVo;
import com.ssafy.yourpilling.pill.model.service.vo.out.OutWeeklyTakerHistoryVo;

import java.util.List;

public interface OwnPillDao {

    OwnPill findByOwnPillId(Long ownPillId);

    void register(OwnPill ownPill);

    PillMember findByMemberId(Long memberId);

    Pill findByPillId(Long pillId);

    void removeByOwnPillId(Long ownPillId);

    void update(OwnPillUpdateVo vo);

    OwnPill takeByOwnPillId(Long ownPillId);

    OutWeeklyTakerHistoryVo findWeeklyTakerHistoriesByMemberId(WeeklyTakerHistoryVo weeklyTakerHistoryVo);

    List<MonthlyTakerHistory> findMonthlyTakerHistoriesByMemberIdAndDate(MonthlyTakerHistoryVo monthlyTakerHistoryVo);
}
