package com.ssafy.yourpilling.member.model.dao.jpa;

import com.ssafy.yourpilling.member.model.dao.entity.MemberProfile;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface MemberJpaRepository extends JpaRepository<MemberProfile, Long> {

    Optional<MemberProfile> findByMemberId(Long memberId);

    Optional<MemberProfile> findByUsername(String username);

    void deleteByMemberId(Long memberId);
}
