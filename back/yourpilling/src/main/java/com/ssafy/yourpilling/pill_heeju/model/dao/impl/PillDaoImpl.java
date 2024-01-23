package com.ssafy.yourpilling.pill_heeju.model.dao.impl;

import com.ssafy.yourpilling.pill_heeju.model.dao.PillDao;
import com.ssafy.yourpilling.pill_heeju.model.dao.entity.PillDetail;
import com.ssafy.yourpilling.pill_heeju.model.dao.jpa.PillJpaRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
@AllArgsConstructor
public class PillDaoImpl implements PillDao {

    private final PillJpaRepository pillJpaRepository;

    @Override
    public Optional<PillDetail> pillDetail(PillDetail pillDetail) {
        return pillJpaRepository.findByPillId(pillDetail.getPillId());
    }
}
