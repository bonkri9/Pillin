package com.ssafy.yourpilling.push.model.dao.jpa;

import com.ssafy.yourpilling.push.model.dao.entity.PushNotification;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PushNotificationsJpaRepository extends JpaRepository<PushNotification, Long> {

    List<PushNotification> findByPushDayAndHourAndMinute(Byte pushDay, int hour, int minute);

}
