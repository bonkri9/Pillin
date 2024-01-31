package com.ssafy.yourpilling.push.controller.mapper;

import com.ssafy.yourpilling.push.controller.dto.request.RequestDeviceTokenDto;
import com.ssafy.yourpilling.push.controller.dto.request.RequestPushMessageDto;
import com.ssafy.yourpilling.push.model.service.vo.in.DeviceTokenVo;
import com.ssafy.yourpilling.push.model.service.vo.in.PushNotificationsVo;
import org.springframework.stereotype.Component;

@Component
public class PushControllerMapper {
    public DeviceTokenVo mapToDeviceTokenVo(Long memberId, RequestDeviceTokenDto dto) {

        return DeviceTokenVo
                .builder()
                .deviceToken(dto.getDeviceToken())
                .memberId(memberId)
                .build();

    }

    public PushNotificationsVo mapToPushNotificationsVo(RequestPushMessageDto dto) {

        return PushNotificationsVo
                .builder()
                .pushDay(dto.getPushDay())
                .pushTime(dto.getPushTime())
                .build();
    }
}
