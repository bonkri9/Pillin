package com.ssafy.yourpilling.push.model.dao;

import com.ssafy.yourpilling.push.model.dao.entity.DeviceToken;

public interface PushDao {
    void register(DeviceToken deviceToken);
}
