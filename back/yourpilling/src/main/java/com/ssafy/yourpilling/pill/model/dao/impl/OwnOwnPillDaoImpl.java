package com.ssafy.yourpilling.pill.model.dao.impl;

import com.ssafy.yourpilling.common.TakeWeekday;
import com.ssafy.yourpilling.pill.model.dao.OwnPillDao;
import com.ssafy.yourpilling.pill.model.dao.entity.OwnPill;
import com.ssafy.yourpilling.pill.model.dao.entity.Pill;
import com.ssafy.yourpilling.pill.model.dao.entity.PillMember;
import com.ssafy.yourpilling.pill.model.dao.jpa.OwnPillJpaRepository;
import com.ssafy.yourpilling.pill.model.dao.jpa.PillJpaRepository;
import com.ssafy.yourpilling.pill.model.dao.jpa.PillMemberJpaRepository;
import com.ssafy.yourpilling.pill.model.service.vo.in.OwnPillUpdateVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class OwnOwnPillDaoImpl implements OwnPillDao {

    private final OwnPillJpaRepository ownPillJpaRepository;
    private final PillJpaRepository pillJpaRepository;
    private final PillMemberJpaRepository pillMemberJpaRepository;

    @Override
    public OwnPill findByOwnPillId(Long ownPillId) {
        return ownPillJpaRepository.findByOwnPillId(ownPillId)
                .orElseThrow(() -> new IllegalArgumentException("사용자가 보유중인 영양제를 찾을 수 없습니다."));
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
    public void removeByOwnPillId(Long ownPillId) {
        ownPillJpaRepository.deleteByOwnPillId(ownPillId)
                .orElseThrow(() -> new IllegalArgumentException("보유중인 영양제 삭제에 실패했습니다."));
    }

    private void updateValues(OwnPillUpdateVo vo, OwnPill ownPill) {
        ownPill.setRemains(vo.getRemains());
        ownPill.setTotalCount(vo.getTotalCount());
        ownPill.setTakeCount(vo.getTakeCount());
        ownPill.setTakeOnceAmount(vo.getTakeOnceAmount());
        ownPill.setTakeYN(vo.getTakeYn());
        ownPill.setStartAt(vo.getStartAt());
        ownPill.setTakeWeekdays(vo.getTakeYn() ? TakeWeekday.toValue(vo.getTakeWeekdays()) : null);
    }
}
