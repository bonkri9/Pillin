package com.ssafy.yourpilling.takerhistory.model.dao.jpa;

import com.ssafy.yourpilling.takerhistory.model.dao.entity.TakerHistoryTakerHistory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface TakerHistoryTakerHistoryRepository extends JpaRepository<TakerHistoryTakerHistory, Long> {

    @Query("SELECT th " +
                  "FROM TakerHistoryTakerHistory th " +
                  "JOIN th.ownPill op " +
                  "JOIN op.pill p " +
                  "WHERE op.member.memberId = :memberId " +
                  "AND th.takeAt = :takeAt")
    List<TakerHistoryTakerHistory> findByTakeAtAndMemberId(@Param("takeAt") LocalDate takeAt, @Param("memberId") Long memberId);

    Optional<TakerHistoryTakerHistory> findByTakeAtAndOwnPillOwnPillId(LocalDate takeAt, Long ownPillId);
}
