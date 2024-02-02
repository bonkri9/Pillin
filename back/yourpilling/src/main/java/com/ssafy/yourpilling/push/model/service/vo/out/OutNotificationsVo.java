package com.ssafy.yourpilling.push.model.service.vo.out;

import com.ssafy.yourpilling.push.model.dao.entity.PushNotification;
import lombok.Builder;
import lombok.Value;

import java.util.List;

@Value
@Builder
public class OutNotificationsVo {

    List<PushNotification> pushNotifications;

}
