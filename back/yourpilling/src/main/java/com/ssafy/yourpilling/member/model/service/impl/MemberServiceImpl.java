package com.ssafy.yourpilling.member.model.service.impl;

import com.ssafy.yourpilling.member.model.dao.MemberDao;
import com.ssafy.yourpilling.member.model.service.MemberService;
import com.ssafy.yourpilling.member.model.service.mapper.MemberServiceMapper;
import com.ssafy.yourpilling.member.model.service.vo.MemberRegisterVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {

    private final MemberDao memberDao;
    private final MemberServiceMapper mapper;


    @Transactional
    @Override
    public void register(MemberRegisterVo vo) {
        memberDao.register(mapper.mapToMember(vo));
    }
}
