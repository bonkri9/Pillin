package com.ssafy.yourpilling.push.model.dao;

import com.ssafy.yourpilling.push.model.dao.entity.DeviceToken;
import com.ssafy.yourpilling.push.model.service.vo.in.PushNotificationsVo;
import com.ssafy.yourpilling.push.model.service.vo.out.OutNotificationsVo;


public interface PushDao {
    void tokenRegister(DeviceToken deviceToken);

    OutNotificationsVo findAllByPushDayAndPushTime(PushNotificationsVo vo);

}
