package com.ssafy.yourpilling.pill.model.dao.impl;

import com.ssafy.yourpilling.common.TakeWeekday;
import com.ssafy.yourpilling.pill.model.dao.OwnPillDao;
import com.ssafy.yourpilling.pill.model.dao.entity.*;
import com.ssafy.yourpilling.pill.model.dao.jpa.*;
import com.ssafy.yourpilling.pill.model.service.vo.in.MonthlyTakerHistoryVo;
import com.ssafy.yourpilling.pill.model.service.vo.in.OwnPillUpdateVo;
import com.ssafy.yourpilling.pill.model.service.vo.in.WeeklyTakerHistoryVo;
import com.ssafy.yourpilling.pill.model.service.vo.out.OutWeeklyTakerHistoryVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class OwnOwnPillDaoImpl implements OwnPillDao {

    private final OwnPillJpaRepository ownPillJpaRepository;
    private final PillJpaRepository pillJpaRepository;
    private final PillMemberJpaRepository pillMemberJpaRepository;
    private final TakerHistoryRepository takerHistoryRepository;
    private final BuyRecordRepository buyRecordRepository;

    @Override
    public void isAlreadyRegister(Long memberId, Long pillId) {
        List<OwnPill> ownPills = findByMemberId(memberId).getOwnPills();

        if (ownPills.stream().anyMatch(ownPill -> ownPill.getPill().equals(pillId))) {
            throw new IllegalArgumentException("이미 등록된 영양제를 재등록할 수 없습니다.");
        }
    }

    @Override
    public OwnPill findByOwnPillId(Long ownPillId) {
        return ownPillJpaRepository.findByOwnPillId(ownPillId)
                .orElseThrow(() -> new IllegalArgumentException("사용자가 보유중인 영양제를 찾을 수 없습니다."));
    }

    @Override
    public void registerHistory(TakerHistory takerHistory) {
        takerHistoryRepository.save(takerHistory);
    }

    @Override
    public void register(OwnPill ownPill) {
        ownPillJpaRepository.save(ownPill);
    }

    @Override
    public PillMember findByMemberId(Long memberId) {
        return pillMemberJpaRepository.findByMemberId(memberId)
                .orElseThrow(() -> new IllegalArgumentException("사용자를 찾을 수 없습니다."));
    }

    @Override
    public Pill findByPillId(Long pillId) {
        return pillJpaRepository.findByPillId(pillId)
                .orElseThrow(() -> new IllegalArgumentException("영양제를 찾을 수 없습니다."));
    }

    @Override
    public void update(OwnPillUpdateVo vo) {
        OwnPill ownPill = findByOwnPillId(vo.getOwnPillId());
        updateValues(vo, ownPill);
    }

    @Override
    public OwnPill takeByOwnPillId(Long ownPillId) {
        return findByOwnPillId(ownPillId);
    }

    @Override
    public OutWeeklyTakerHistoryVo findWeeklyTakerHistoriesByMemberId(WeeklyTakerHistoryVo weeklyTakerHistoryVo) {
        return  OutWeeklyTakerHistoryVo
                .builder()
                .data(takerHistoryRepository.findWeeklyTakerHistoriesByMemberId(weeklyTakerHistoryVo.getMemberId()))
                .build();
    }

    @Override
    public List<MonthlyTakerHistory> findMonthlyTakerHistoriesByMemberIdAndDate(MonthlyTakerHistoryVo monthlyTakerHistoryVo) {
        List<MonthlyTakerHistory> tmp = takerHistoryRepository.findTakerHistoryDetailsByMemberIdAndMonth(monthlyTakerHistoryVo.getMemberId(), monthlyTakerHistoryVo.getDate().getYear(), monthlyTakerHistoryVo.getDate().getMonthValue());
        return tmp;
    }

    @Override
    public void removeByOwnPillId(Long ownPillId) {
        ownPillJpaRepository.deleteByOwnPillId(ownPillId)
                .orElseThrow(() -> new IllegalArgumentException("보유중인 영양제 삭제에 실패했습니다."));
    }

    @Override
    public void buyRecord(BuyRecord buyRecord) {
        buyRecordRepository.save(buyRecord);
    }

    private void updateValues(OwnPillUpdateVo vo, OwnPill ownPill) {
        ownPill.setRemains(vo.getRemains());
        ownPill.setTotalCount(vo.getTotalCount());
    }
}
