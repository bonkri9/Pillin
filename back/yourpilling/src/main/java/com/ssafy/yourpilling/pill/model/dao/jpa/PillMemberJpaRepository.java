package com.ssafy.yourpilling.pill.model.dao.jpa;

import com.ssafy.yourpilling.pill.model.dao.entity.PillMember;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface PillMemberJpaRepository extends JpaRepository<PillMember, Long> {

    Optional<PillMember> findByMemberId(Long memberId);
}
