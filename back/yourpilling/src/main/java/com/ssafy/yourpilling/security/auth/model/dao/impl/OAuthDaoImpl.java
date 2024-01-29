package com.ssafy.yourpilling.security.auth.model.dao.impl;

import com.ssafy.yourpilling.security.auth.model.dao.OAuthDao;
import com.ssafy.yourpilling.security.auth.model.dao.entity.Member;
import com.ssafy.yourpilling.security.auth.model.dao.jpa.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
@RequiredArgsConstructor
public class OAuthDaoImpl implements OAuthDao {

    private final MemberRepository memberRepository;

    @Override
    public Optional<Member> findByUsername(String username) {
        return memberRepository.findByUsername(username);
    }

    @Override
    public void register(Member member) {
        memberRepository.save(member);
    }
}
