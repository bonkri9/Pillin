package com.ssafy.yourpilling.push.model.service.mapper;

import com.ssafy.yourpilling.push.model.dao.entity.DeviceToken;
import com.ssafy.yourpilling.push.model.dao.entity.PushMember;
import com.ssafy.yourpilling.push.model.dao.entity.PushNotification;
import com.ssafy.yourpilling.push.model.service.vo.in.DeviceTokenVo;
import com.ssafy.yourpilling.push.model.service.vo.in.RegistPushNotificationVo;
import org.springframework.stereotype.Component;


@Component
public class PushServiceMapper {

    public DeviceToken mapToDeviceToken(DeviceTokenVo deviceTokenVo) {

        return DeviceToken
                .builder()
                .deviceToken(deviceTokenVo.getDeviceToken())
                .member(PushMember.builder().memberId(deviceTokenVo.getMemberId()).build())
                .build();

    }


    public PushNotification mapToPushNotification(int pushDay, RegistPushNotificationVo vo, PushMember member) {

        return  PushNotification
                .builder()
                .pushDay(pushDay)
                .hour(vo.getHour())
                .minute(vo.getMinute())
                .message(vo.getMessage())
                .member(member)
                .build();

    }




}
