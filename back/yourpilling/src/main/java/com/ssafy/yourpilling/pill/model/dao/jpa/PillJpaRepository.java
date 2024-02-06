package com.ssafy.yourpilling.pill.model.dao.jpa;

import com.ssafy.yourpilling.pill.model.dao.entity.Pill;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface PillJpaRepository extends JpaRepository<Pill, Long> {
    Optional<Pill> findByPillId(Long pillId);

    Optional<Pill> findByName(String name);
}
