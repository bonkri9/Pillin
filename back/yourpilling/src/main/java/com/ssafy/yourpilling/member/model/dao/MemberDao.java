package com.ssafy.yourpilling.member.model.dao;

import com.ssafy.yourpilling.common.Gender;
import com.ssafy.yourpilling.member.model.dao.entity.MemberProfile;
import com.ssafy.yourpilling.member.model.service.vo.in.MemberInfoVo;

import java.time.LocalDate;

public interface MemberDao {

    void register(MemberProfile memberProfile);

    MemberProfile findByMemberId(Long memberId);

    void deleteByMemberId(Long memberId);

    MemberProfile findByUsername(String username);
}
