package com.ssafy.yourpilling.push.model.service;

import com.ssafy.yourpilling.push.model.service.vo.in.*;
import com.ssafy.yourpilling.push.model.service.vo.out.OutNotificationsVo;

public interface PushService {
    void register(DeviceTokenVo deviceTokenVo);

    OutNotificationsVo findAllByPushDayAndPushTime(PushNotificationVo vo);

    void registPushNotification(RegistPushNotificationVo registPushNotificationVo);

    void updatePushNotification(UpdatePushNotificationVo updatePushNotificationVo);

    void DeletePushNotification(DeletePushNotificationsVo deletePushNotificationsVo);
}
