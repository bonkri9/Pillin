package com.ssafy.yourpilling.push.model.service;

import com.ssafy.yourpilling.push.model.service.vo.DeviceTokenVo;

public interface PushService {
    void register(DeviceTokenVo deviceTokenVo);
}
