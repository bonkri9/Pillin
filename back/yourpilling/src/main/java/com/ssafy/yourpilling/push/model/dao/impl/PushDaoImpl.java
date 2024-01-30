package com.ssafy.yourpilling.push.model.dao.impl;

import com.ssafy.yourpilling.push.model.dao.PushDao;
import com.ssafy.yourpilling.push.model.dao.entity.DeviceToken;
import com.ssafy.yourpilling.push.model.dao.jpa.DeviceTokenJpaRepository;
import com.ssafy.yourpilling.push.model.dao.jpa.PushNotificationsJpaRepository;
import com.ssafy.yourpilling.push.model.service.vo.in.DeviceTokenVo;
import com.ssafy.yourpilling.push.model.service.vo.in.PushNotificationsVo;
import com.ssafy.yourpilling.push.model.service.vo.out.OutNotificationsVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;


@Repository
@RequiredArgsConstructor
public class PushDaoImpl implements PushDao {

    private final DeviceTokenJpaRepository deviceTokenJpaRepository;
    private final PushNotificationsJpaRepository pushNotificationsJpaRepository;

    @Override
    public void tokenRegister(DeviceToken deviceToken) {
        deviceTokenJpaRepository.findByMemberMemberIdAndDeviceToken(deviceToken.getMember().getMemberId(), deviceToken.getDeviceToken())
                .ifPresent(e -> {
                    throw new IllegalArgumentException("이미 존재하는 디바이스 토큰입니다.");
                });

        deviceTokenJpaRepository.save(deviceToken);
    }

    @Override
    public OutNotificationsVo findAllByPushDayAndPushTime(PushNotificationsVo vo) {

        return OutNotificationsVo
                .builder()
                .pushNotifications(
                        pushNotificationsJpaRepository.findByPushDayAndPushTime(vo.getPushDay(), vo.getPushTime())
                )
                .build();
    }

    @Override
    public void deleteByMemberIdAndDeviceToken(DeviceTokenVo deviceTokenVo) {
        deviceTokenJpaRepository.deleteByMemberMemberIdAndDeviceToken(deviceTokenVo.getMemberId(), deviceTokenVo.getDeviceToken());
    }


}
