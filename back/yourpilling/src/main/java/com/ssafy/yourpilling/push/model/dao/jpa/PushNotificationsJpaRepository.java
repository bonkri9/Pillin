package com.ssafy.yourpilling.push.model.dao.jpa;

import com.ssafy.yourpilling.push.model.dao.entity.PushNotification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface PushNotificationsJpaRepository extends JpaRepository<PushNotification, Long> {

    void deleteByPushId(Long pushId);

    @Query("SELECT pn FROM PushNotification pn JOIN pn.messageInfos pmi WHERE pn.pushHour = :pushHour AND pn.pushMinute = :pushMinute AND pmi.pushDay = :pushDay")
    List<PushNotification> findByPushTimeAndDay(@Param("pushHour") int pushHour, @Param("pushMinute") int pushMinute, @Param("pushDay") int pushDay);

}
