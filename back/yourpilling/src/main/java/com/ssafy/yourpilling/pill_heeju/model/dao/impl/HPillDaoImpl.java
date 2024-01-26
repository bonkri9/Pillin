package com.ssafy.yourpilling.pill_heeju.model.dao.impl;

import com.ssafy.yourpilling.pill_heeju.model.dao.PillDao;
import com.ssafy.yourpilling.pill_heeju.model.dao.entity.PillDetail;
import com.ssafy.yourpilling.pill_heeju.model.dao.jpa.HPillJpaRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Repository;
import java.util.List;

import java.util.List;
import java.util.Optional;

@Repository
@AllArgsConstructor
public class HPillDaoImpl implements PillDao {

    private final HPillJpaRepository pillJpaRepository;

    @Override
    public PillDetail pillDetail(PillDetail pillDetail) {
        return pillJpaRepository.findByPillId(pillDetail.getPillId())
                .orElseThrow(() -> new IllegalArgumentException("해당 영양제의 정보가 존재하지 않습니다."));
    }

    @Override
    public List<PillDetail> pillSearchList(PillDetail pillDetail) {
        List<PillDetail> pills = pillJpaRepository.findByNameContains(pillDetail.getName());

        return Optional.of(pills)
                .filter(pillList -> !pillList.isEmpty())
                .orElseThrow(() -> new IllegalArgumentException("해당하는 영양제가 존재하지 않습니다."));
    }
}
