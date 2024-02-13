package com.ssafy.yourpilling.analysis.model.dao.jpa;

import com.ssafy.yourpilling.analysis.model.dao.entity.AnalysisOwnPill;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface AnalysisOwnPillRepository extends JpaRepository<AnalysisOwnPill, Long> {

    List<AnalysisOwnPill> findByMemberMemberIdAndTakeYn(Long memberId, boolean takeYn);
}
