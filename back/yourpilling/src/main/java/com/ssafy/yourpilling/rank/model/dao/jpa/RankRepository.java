package com.ssafy.yourpilling.rank.model.dao.jpa;

import com.ssafy.yourpilling.rank.model.dao.entity.Rank;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RankRepository extends JpaRepository<Rank, Long> {
}
