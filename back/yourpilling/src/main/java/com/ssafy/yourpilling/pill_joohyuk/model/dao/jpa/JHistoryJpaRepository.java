package com.ssafy.yourpilling.pill_joohyuk.model.dao.jpa;

import com.ssafy.yourpilling.pill_joohyuk.model.dao.entity.JTakerHistory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface JHistoryJpaRepository extends JpaRepository<JTakerHistory, Long> {

    @Query("SELECT th " +
            "FROM JTakerHistory th " +
            "JOIN th.ownPill op " +
            "JOIN op.pill p " +
            "WHERE op.member.memberId = :memberId " +
            "AND th.takeAt = :takeAt")
    List<JTakerHistory> findByTakeAtAndMemberId(LocalDate takeAt, Long memberId);

    Optional<JTakerHistory> findByTakeAtAndOwnPillOwnPillId(LocalDate takeAt, Long ownPillId);

}
