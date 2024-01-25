package com.ssafy.yourpilling.pill.model.dao;


import com.ssafy.yourpilling.pill.model.dao.entity.OwnPill;
import com.ssafy.yourpilling.pill.model.dao.entity.Pill;
import com.ssafy.yourpilling.pill.model.dao.entity.PillMember;

public interface OwnPillDao {

    OwnPill findByOwnPillId(Long ownPillId);

    void register(OwnPill ownPill);

    PillMember findByMemberId(Long memberId);

    Pill findByPillId(Long pillId);
}
