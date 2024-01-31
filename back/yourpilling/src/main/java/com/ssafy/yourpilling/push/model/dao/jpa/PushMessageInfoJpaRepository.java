package com.ssafy.yourpilling.push.model.dao.jpa;

import com.ssafy.yourpilling.push.model.dao.entity.PushMessageInfo;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PushMessageInfoJpaRepository extends JpaRepository<PushMessageInfo, Long> {

    List<PushMessageInfo> findByPushDayAndPushHourAndPushMinute(Byte pushDay, int hour, int minute);

}
