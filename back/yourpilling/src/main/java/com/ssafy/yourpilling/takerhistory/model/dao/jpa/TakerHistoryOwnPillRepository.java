package com.ssafy.yourpilling.takerhistory.model.dao.jpa;

import com.ssafy.yourpilling.takerhistory.model.dao.entity.TakerHistoryOwnPill;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface TakerHistoryOwnPillRepository extends JpaRepository<TakerHistoryOwnPill, Long> {

    @Query("SELECT t FROM TakerHistoryOwnPill t WHERE t.takeYn = true AND (FUNCTION('BITAND', t.takeWeekdays, :bitmask)) > 0")
    List<TakerHistoryOwnPill> findByTakeYnTrueAndTakeWeekdaysBitwiseAnd(@Param("bitmask") int bitmask);
}
