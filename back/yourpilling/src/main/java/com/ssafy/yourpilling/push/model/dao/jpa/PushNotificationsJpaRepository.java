package com.ssafy.yourpilling.push.model.dao.jpa;

import com.ssafy.yourpilling.push.model.dao.entity.PushNotification;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDateTime;
import java.util.List;

public interface PushNotificationsJpaRepository extends JpaRepository<PushNotification, Long> {
    List<PushNotification> findByPushDayAndPushTime(Byte pushDay, LocalDateTime pushTime);
}
