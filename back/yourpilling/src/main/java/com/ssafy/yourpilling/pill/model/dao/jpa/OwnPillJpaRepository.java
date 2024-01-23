package com.ssafy.yourpilling.pill.model.dao.jpa;

import com.ssafy.yourpilling.pill.model.dao.entity.OwnPill;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OwnPillJpaRepository extends JpaRepository<OwnPill, Long> {
}
