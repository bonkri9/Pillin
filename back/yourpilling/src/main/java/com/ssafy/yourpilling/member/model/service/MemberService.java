package com.ssafy.yourpilling.member.model.service;

import com.ssafy.yourpilling.member.model.service.vo.in.*;
import com.ssafy.yourpilling.member.model.service.vo.out.OutMemberVo;

public interface MemberService {

    void register(MemberRegisterVo vo);

    OutMemberVo info(MemberInfoVo vo);

    void updateName(MemberUpdateNameVo vo);

    void updatePassword(MemberUpdatePasswordVo vo);

    void delete(MemberDeleteVo vo);

    void passwordReIssue(MemberPasswordReIssueVo vo);

    void registerEssential(RegisterEssentialVo vo);
}
