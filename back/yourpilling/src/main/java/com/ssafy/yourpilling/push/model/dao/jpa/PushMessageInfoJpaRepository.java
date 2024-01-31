package com.ssafy.yourpilling.push.model.dao.jpa;

import com.ssafy.yourpilling.push.model.dao.entity.PushMessageInfo;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PushMessageInfoJpaRepository extends JpaRepository<PushMessageInfo, Long> {

}
