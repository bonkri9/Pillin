package com.ssafy.yourpilling.push.model.service;

import com.ssafy.yourpilling.push.model.service.vo.in.DeviceTokenVo;
import com.ssafy.yourpilling.push.model.service.vo.in.PushNotificationVo;
import com.ssafy.yourpilling.push.model.service.vo.in.RegistPushNotificationVo;
import com.ssafy.yourpilling.push.model.service.vo.in.UpdatePushNotificationVo;
import com.ssafy.yourpilling.push.model.service.vo.out.OutNotificationsVo;

public interface PushService {
    void register(DeviceTokenVo deviceTokenVo);

    OutNotificationsVo findAllByPushDayAndPushTime(PushNotificationVo vo);

    void registPushNotification(RegistPushNotificationVo registPushNotificationVo);

    void updatePushNotification(UpdatePushNotificationVo updatePushNotificationVo);
}
