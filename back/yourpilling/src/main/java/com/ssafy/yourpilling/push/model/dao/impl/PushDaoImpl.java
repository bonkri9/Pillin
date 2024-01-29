package com.ssafy.yourpilling.push.model.dao.impl;

import com.ssafy.yourpilling.push.model.dao.PushDao;
import com.ssafy.yourpilling.push.model.dao.entity.DeviceToken;
import com.ssafy.yourpilling.push.model.dao.jpa.DeviceTokenJpaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class PushDaoImpl implements PushDao {

    private final DeviceTokenJpaRepository deviceTokenJpaRepository;

    @Override
    public void register(DeviceToken deviceToken) {
        deviceTokenJpaRepository.findByMemberMemberIdAndDeviceToken(deviceToken.getMember().getMemberId(), deviceToken.getDeviceToken())
                .ifPresent(e -> {
                    throw new IllegalArgumentException("이미 존재하는 디바이스 토큰입니다.");
                });

        deviceTokenJpaRepository.save(deviceToken);
    }
}
