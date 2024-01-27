package com.ssafy.yourpilling.pill_joohyuk.model.dao.jpa;

import com.ssafy.yourpilling.pill_joohyuk.model.dao.entity.JPillMember;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface JPillMemberJpaRepository extends JpaRepository<JPillMember, Long> {
    Optional<JPillMember> findByMemberId(Long memberId);
}
