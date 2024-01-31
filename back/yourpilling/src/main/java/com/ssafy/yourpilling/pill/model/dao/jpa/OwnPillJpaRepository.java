package com.ssafy.yourpilling.pill.model.dao.jpa;

import com.ssafy.yourpilling.pill.model.dao.entity.OwnPill;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface OwnPillJpaRepository extends JpaRepository<OwnPill, Long> {

    Optional<OwnPill> findByOwnPillId(Long ownPillId);

    Optional<Void> deleteByOwnPillId(Long ownPillId);
}
