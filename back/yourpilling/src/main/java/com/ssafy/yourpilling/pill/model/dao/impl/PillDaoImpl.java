package com.ssafy.yourpilling.pill.model.dao.impl;

import com.ssafy.yourpilling.pill.model.dao.PillDao;
import com.ssafy.yourpilling.pill.model.dao.entity.OwnPill;
import com.ssafy.yourpilling.pill.model.dao.entity.Pill;
import com.ssafy.yourpilling.pill.model.dao.entity.PillMember;
import com.ssafy.yourpilling.pill.model.dao.jpa.OwnPillJpaRepository;
import com.ssafy.yourpilling.pill.model.dao.jpa.PillJpaRepository;
import com.ssafy.yourpilling.pill.model.dao.jpa.PillMemberJpaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class PillDaoImpl implements PillDao {

    private final OwnPillJpaRepository ownPillJpaRepository;
    private final PillJpaRepository pillJpaRepository;
    private final PillMemberJpaRepository pillMemberJpaRepository;

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
}
