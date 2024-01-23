package com.ssafy.yourpilling.pill_heeju.model.dao.jpa;

import com.ssafy.yourpilling.pill_heeju.model.dao.entity.PillDetail;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface PillJpaRepository extends JpaRepository<PillDetail, Long> {

    Optional<PillDetail> findByPillId(Long aLong);
}
