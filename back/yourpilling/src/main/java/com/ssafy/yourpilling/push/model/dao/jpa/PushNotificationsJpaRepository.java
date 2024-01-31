package com.ssafy.yourpilling.push.model.dao.jpa;

import com.ssafy.yourpilling.push.model.dao.entity.PushNotification;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PushNotificationsJpaRepository extends JpaRepository<PushNotification, Long> {

}
