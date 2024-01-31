package com.ssafy.yourpilling.takerhistory.model.dao.jpa;

import com.ssafy.yourpilling.takerhistory.model.dao.entity.TakerHistoryPill;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface TakerHistoryPillRepository extends JpaRepository<TakerHistoryPill, Long> {

    Optional<TakerHistoryPill> findByName(String name);
}
