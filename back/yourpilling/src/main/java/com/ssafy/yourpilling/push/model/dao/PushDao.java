package com.ssafy.yourpilling.push.model.dao;

import com.ssafy.yourpilling.push.model.dao.entity.DeviceToken;
import com.ssafy.yourpilling.push.model.dao.entity.PushMember;
import com.ssafy.yourpilling.push.model.service.vo.in.DeletePushNotificationsVo;
import com.ssafy.yourpilling.push.model.service.vo.in.PushNotificationVo;
import com.ssafy.yourpilling.push.model.service.vo.in.RegistPushNotificationVo;
import com.ssafy.yourpilling.push.model.service.vo.in.UpdatePushNotificationVo;
import com.ssafy.yourpilling.push.model.service.vo.out.OutNotificationsVo;

import java.util.List;


public interface PushDao {
    void tokenRegister(DeviceToken deviceToken);

    OutNotificationsVo findAllByPushDayAndPushTime(PushNotificationVo vo);

    void  registPushNotification(RegistPushNotificationVo vo);

    PushMember findByMemberId(Long memberId);

    void deletePushNotificationById(DeletePushNotificationsVo vo);

    void updatePushNotification(UpdatePushNotificationVo vo);

    List<PushMember> findAllPushMember();
}
