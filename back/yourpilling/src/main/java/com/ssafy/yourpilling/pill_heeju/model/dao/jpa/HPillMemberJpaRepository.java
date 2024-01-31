package com.ssafy.yourpilling.pill_heeju.model.dao.jpa;

import com.ssafy.yourpilling.pill_heeju.model.dao.entity.HPillMember;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface HPillMemberJpaRepository extends JpaRepository<HPillMember, Long> {

    Optional<HPillMember> findByMemberId(Long memberId);
}
