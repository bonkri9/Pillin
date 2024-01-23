package com.ssafy.yourpilling.security.auth.repository;

import com.ssafy.yourpilling.security.auth.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface MemberRepository extends JpaRepository<Member, Long> {

    Optional<Member> findByMemberId(Long memberId);

    Optional<Member> findByUsername(String username);
}

