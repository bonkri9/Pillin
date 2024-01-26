package com.ssafy.yourpilling.pill.model.dao;

import com.ssafy.yourpilling.pill.model.dao.entity.OwnPill;
import com.ssafy.yourpilling.pill.model.dao.entity.Pill;
import com.ssafy.yourpilling.pill.model.dao.entity.PillMember;
import com.ssafy.yourpilling.pill.model.service.vo.in.OwnPillUpdateVo;

public interface OwnPillDao {

    OwnPill findByOwnPillId(Long ownPillId);

    void register(OwnPill ownPill);

    PillMember findByMemberId(Long memberId);

    Pill findByPillId(Long pillId);

    void removeByOwnPillId(Long ownPillId);

    void update(OwnPillUpdateVo vo);
}
