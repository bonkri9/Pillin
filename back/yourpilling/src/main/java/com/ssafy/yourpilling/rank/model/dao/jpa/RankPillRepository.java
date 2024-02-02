package com.ssafy.yourpilling.rank.model.dao.jpa;

import com.ssafy.yourpilling.rank.model.dao.entity.RankPill;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface RankPillRepository extends JpaRepository<RankPill, Long> {

    Optional<RankPill> findByPillId(Long pillId);
}
