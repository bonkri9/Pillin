package com.ssafy.yourpilling.member.model.dao.impl;

import com.ssafy.yourpilling.member.model.dao.MemberDao;
import com.ssafy.yourpilling.member.model.dao.entity.MemberProfile;
import com.ssafy.yourpilling.member.model.dao.jpa.MemberJpaRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Repository;

@Repository
@AllArgsConstructor
public class MemberDaoImpl implements MemberDao {

    private final MemberJpaRepository memberJpaRepository;

    @Override
    public void register(MemberProfile memberProfile) {
        memberJpaRepository.findByUsername(memberProfile.getUsername())
                .ifPresent(e -> {
                    throw new IllegalArgumentException("이미 존재하는 이메일입니다.");
                });

        memberJpaRepository.save(memberProfile);
    }
}
