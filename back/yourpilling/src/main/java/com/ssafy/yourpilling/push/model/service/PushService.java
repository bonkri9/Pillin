package com.ssafy.yourpilling.push.model.service;

import com.ssafy.yourpilling.push.model.service.vo.in.DeviceTokenVo;
import com.ssafy.yourpilling.push.model.service.vo.in.PushNotificationsVo;
import com.ssafy.yourpilling.push.model.service.vo.out.OutNotificationsVo;

public interface PushService {
    void registToken(DeviceTokenVo deviceTokenVo);

    OutNotificationsVo findAllByPushDayAndPushTime(PushNotificationsVo vo);

    void deleteToken(DeviceTokenVo deviceTokenVo);
}
