package com.ssafy.yourpilling.pill.model.dao.jpa;

import com.ssafy.yourpilling.pill.model.dao.entity.BuyRecord;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BuyRecordRepository extends JpaRepository<BuyRecord, Long> {
}
