package com.ssafy.yourpilling.pill_joohyuk.model.dao.jpa;

import com.ssafy.yourpilling.pill_joohyuk.model.dao.entity.JPill;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface JPillJpaRepository extends JpaRepository<JPill, Long> {

    Optional<JPill> findByName(String name);

}
