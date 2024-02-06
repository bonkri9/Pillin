package com.ssafy.yourpilling.analysis.model.dao.jpa;



import com.ssafy.yourpilling.analysis.model.dao.entity.AnalysisMember;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface AnalysisMemberRepository extends JpaRepository<AnalysisMember, Long> {
    Optional<AnalysisMember> findByMemberId(Long memberId);
}
