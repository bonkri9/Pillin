package com.ssafy.yourpilling.takerhistory.model.dao.jpa;

import com.ssafy.yourpilling.takerhistory.model.dao.entity.TakerHistoryTakerHistory;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.Optional;

public interface TakerHistoryTakerHistoryRepository extends JpaRepository<TakerHistoryTakerHistory, Long> {

    Optional<TakerHistoryTakerHistory> findByTakeAtAndOwnPillOwnPillId(LocalDate takeAt, Long ownPillId);
}
