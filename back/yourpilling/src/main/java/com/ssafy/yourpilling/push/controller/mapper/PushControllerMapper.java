package com.ssafy.yourpilling.push.controller.mapper;

import com.ssafy.yourpilling.push.controller.dto.request.RequestDeviceTokenDto;
import com.ssafy.yourpilling.push.model.service.vo.DeviceTokenVo;
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
}
