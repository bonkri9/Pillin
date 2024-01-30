package com.ssafy.yourpilling.push.model.service.mapper;

import com.ssafy.yourpilling.push.model.dao.entity.DeviceToken;
import com.ssafy.yourpilling.push.model.dao.entity.PushMember;
import com.ssafy.yourpilling.push.model.service.vo.in.DeviceTokenVo;
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


}
