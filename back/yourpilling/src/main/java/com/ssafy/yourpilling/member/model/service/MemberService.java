package com.ssafy.yourpilling.member.model.service;

import com.ssafy.yourpilling.member.model.service.vo.in.*;
import com.ssafy.yourpilling.member.model.service.vo.out.OutMemberVo;

public interface MemberService {

    void register(MemberRegisterVo memberRegisterVo);

    OutMemberVo info(MemberInfoVo vo);

    void update(MemberUpdateVo vo);

    void delete(MemberDeleteVo vo);

    void passwordReIssue(MemberPasswordReIssueVo vo);
}
