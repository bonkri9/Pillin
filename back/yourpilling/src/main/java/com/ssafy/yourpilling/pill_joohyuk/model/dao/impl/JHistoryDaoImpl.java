package com.ssafy.yourpilling.pill_joohyuk.model.dao.impl;

import com.ssafy.yourpilling.pill_joohyuk.model.dao.JHistoryDao;
import com.ssafy.yourpilling.pill_joohyuk.model.dao.entity.JTakerHistory;
import com.ssafy.yourpilling.pill_joohyuk.model.dao.jpa.JHistoryJpaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
@RequiredArgsConstructor
public class JHistoryDaoImpl implements JHistoryDao {

    private final JHistoryJpaRepository takerHistoryJpaRepository;

    @Override
    public List<JTakerHistory> findByTakeAtAndMemberId(LocalDate takeAt, Long ownPillId) {
        return takerHistoryJpaRepository.findByTakeAtAndMemberId(takeAt, ownPillId);
    }
}
