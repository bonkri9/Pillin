package com.ssafy.yourpilling.takerhistory.model.dao.jpa;

import com.ssafy.yourpilling.takerhistory.model.dao.entity.TakerHistoryPillMember;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface TakerHistoryPillMemberRepository extends JpaRepository<TakerHistoryPillMember, Long> {

    Optional<TakerHistoryPillMember> findByMemberId(Long MemberId);
}
