package com.ssafy.yourpilling.member.model.service;

import com.ssafy.yourpilling.member.model.service.vo.in.MemberDeleteVo;
import com.ssafy.yourpilling.member.model.service.vo.in.MemberInfoVo;
import com.ssafy.yourpilling.member.model.service.vo.in.MemberRegisterVo;
import com.ssafy.yourpilling.member.model.service.vo.in.MemberUpdateVo;
import com.ssafy.yourpilling.member.model.service.vo.out.OutMemberVo;

public interface MemberService {

    void register(MemberRegisterVo memberRegisterVo);

    OutMemberVo info(MemberInfoVo vo);

    void update(MemberUpdateVo vo);

    void delete(MemberDeleteVo vo);
}
