package com.ssafy.yourpilling.push.model.dao.jpa;

import com.ssafy.yourpilling.push.model.dao.entity.PushMember;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface PushMemberJpaRepository extends JpaRepository<PushMember, Long> {

    Optional<PushMember> findByMemberId(Long memberId);

}
