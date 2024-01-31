package com.ssafy.yourpilling.push.controller.mapper;

import com.ssafy.yourpilling.push.controller.dto.request.*;
import com.ssafy.yourpilling.push.model.service.vo.in.*;
import org.springframework.stereotype.Component;

@Component
public class PushControllerMapper {
    private final String SUFFIX = " 섭취하실 시간입니다.";
    public DeviceTokenVo mapToDeviceTokenVo(Long memberId, RequestDeviceTokenDto dto) {

        return DeviceTokenVo
                .builder()
                .deviceToken(dto.getDeviceToken())
                .memberId(memberId)
                .build();

    }

    public PushNotificationVo mapToPushNotificationsVo(RequestPushFcmDto dto) {

        return PushNotificationVo
                .builder()
                .pushDay(dto.getPushDay())

                .build();
    }

    public RegistPushNotificationVo mapToRegistPushNotificationVo(Long memberId, RequestPushNotificationsDto dto) {

        return RegistPushNotificationVo
                .builder()
                .memberId(memberId)
                .day(dto.getDay())
                .hour(dto.getHour())
                .minute(dto.getMinute())
                .message(dto.getOwnPillName() + SUFFIX)
                .build();

    }

    public UpdatePushNotificationVo mapToUpdatePushNotificationVo(Long memberId, RequestUpdatePushNotificationDto dto) {

        return UpdatePushNotificationVo
                .builder()
                .memberId(memberId)
                .pushId(dto.getPushId())
                .day(dto.getDay())
                .hour(dto.getHour())
                .minute(dto.getMinute())
                .build();
    }

    public DeletePushNotificationsVo mapToDeletePushNotificationVo(Long memberId, RequestDeletePushNotificationsDto dto) {

        return DeletePushNotificationsVo
                .builder()
                .pushId(dto.getPushId())
                .build();
    }
}
