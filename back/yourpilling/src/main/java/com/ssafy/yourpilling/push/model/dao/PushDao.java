package com.ssafy.yourpilling.push.model.dao;

import com.ssafy.yourpilling.push.model.dao.entity.DeviceToken;
import com.ssafy.yourpilling.push.model.dao.entity.PushMember;
import com.ssafy.yourpilling.push.model.dao.entity.PushNotification;
import com.ssafy.yourpilling.push.model.service.vo.in.PushNotificationVo;
import com.ssafy.yourpilling.push.model.service.vo.out.OutNotificationsVo;


public interface PushDao {
    void tokenRegister(DeviceToken deviceToken);

    OutNotificationsVo findAllByPushDayAndPushTime(PushNotificationVo vo);

    void registPushNotification(PushNotification vo);

    PushMember findByMemberId(Long memberId);

}
