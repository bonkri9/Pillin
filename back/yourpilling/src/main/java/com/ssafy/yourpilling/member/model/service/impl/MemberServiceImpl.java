package com.ssafy.yourpilling.member.model.service.impl;

import com.ssafy.yourpilling.common.Role;
import com.ssafy.yourpilling.member.model.dao.MemberDao;
import com.ssafy.yourpilling.member.model.dao.entity.MemberProfile;
import com.ssafy.yourpilling.member.model.service.MemberService;
import com.ssafy.yourpilling.member.model.service.mapper.MemberServiceMapper;
import com.ssafy.yourpilling.member.model.service.vo.in.MemberInfoVo;
import com.ssafy.yourpilling.member.model.service.vo.in.MemberRegisterVo;
import com.ssafy.yourpilling.member.model.service.vo.in.MemberUpdateVo;
import com.ssafy.yourpilling.member.model.service.vo.out.OutMemberVo;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {

    private final MemberDao memberDao;
    private final MemberServiceMapper mapper;
    private final BCryptPasswordEncoder encoder;

    @Transactional
    @Override
    public void register(MemberRegisterVo vo) {
        memberDao.register(mapper.mapToMember(vo, encoder, Role.MEMBER));
    }

    @Override
    public OutMemberVo info(MemberInfoVo vo) {
        MemberProfile member = memberDao.findByMemberId(vo.getMemberId());

        return mapper.mapToOutMemberVo(member);
    }

    @Transactional
    @Override
    public void update(MemberUpdateVo vo) {
        MemberProfile member = memberDao.findByMemberId(vo.getMemberId());

        member.updateNickname(vo.getNickname());
    }
}
