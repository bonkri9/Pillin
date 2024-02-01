package com.ssafy.yourpilling.pill.model.dao.jpa;

import com.ssafy.yourpilling.pill.model.dao.entity.MonthlyTakerHistory;
import com.ssafy.yourpilling.pill.model.dao.entity.TakerHistory;
import com.ssafy.yourpilling.pill.model.dao.entity.WeeklyHistoryInterface;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface TakerHistoryRepository  extends JpaRepository<TakerHistory, Long> {
    @Query(value = "SELECT th.take_at as date, SUM(th.need_to_take_count) AS needToTakenCountToday , SUM(th.current_take_count) AS actualTakenToday  " +
            "FROM TakerHistory th " +
            "JOIN ownPill op ON th.own_pill_id = op.own_pill_id " +
            "WHERE op.member_id = ?1 AND YEAR(th.take_at) = YEAR(NOW()) AND WEEK(th.take_at, 1) = WEEK(NOW(), 1) " +
            "GROUP BY th.take_at", nativeQuery = true)
    List<WeeklyHistoryInterface> findWeeklyTakerHistoriesByMemberId(Long memberId);


    @Query("SELECT " +
            "new com.ssafy.yourpilling.pill.model.dao.entity.MonthlyTakerHistory(th.takeAt, p.name, th.currentTakeCount , th.needToTakeCount) " +
            "FROM TakerHistory th JOIN th.ownPill op JOIN op.pill p " +
            "WHERE op.member.memberId = :memberId AND YEAR(th.takeAt) = :year AND MONTH(th.takeAt) = :month")
    List<MonthlyTakerHistory> findTakerHistoryDetailsByMemberIdAndMonth(@Param("memberId") Long memberId, @Param("year") int year, @Param("month") int month);


}
