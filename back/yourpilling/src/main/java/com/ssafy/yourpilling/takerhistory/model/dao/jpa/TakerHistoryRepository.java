package com.ssafy.yourpilling.takerhistory.model.dao.jpa;

import com.ssafy.yourpilling.takerhistory.model.dao.entity.TakerHistory;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.Optional;

public interface TakerHistoryRepository extends JpaRepository<TakerHistory, Long> {

    Optional<TakerHistory> findByTakeAtAndOwnPillOwnPillId(LocalDate takeAt, Long ownPillId);
}
