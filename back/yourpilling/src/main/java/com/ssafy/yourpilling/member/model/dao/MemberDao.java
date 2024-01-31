package com.ssafy.yourpilling.member.model.dao;

import com.ssafy.yourpilling.member.model.dao.entity.MemberProfile;
import com.ssafy.yourpilling.member.model.service.vo.in.MemberInfoVo;

public interface MemberDao {

    void register(MemberProfile memberProfile);

    MemberProfile findByMemberId(Long memberId);

    void deleteByMemberId(Long memberId);
}
