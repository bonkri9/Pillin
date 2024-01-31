package com.ssafy.yourpilling.push.model.dao.impl;

import com.ssafy.yourpilling.push.model.dao.PushDao;
import com.ssafy.yourpilling.push.model.dao.entity.DeviceToken;
import com.ssafy.yourpilling.push.model.dao.entity.PushMember;
import com.ssafy.yourpilling.push.model.dao.entity.PushNotification;
import com.ssafy.yourpilling.push.model.dao.jpa.DeviceTokenJpaRepository;
import com.ssafy.yourpilling.push.model.dao.jpa.PushMemberJpaRepository;
import com.ssafy.yourpilling.push.model.dao.jpa.PushNotificationsJpaRepository;
import com.ssafy.yourpilling.push.model.service.vo.in.PushNotificationVo;
import com.ssafy.yourpilling.push.model.service.vo.out.OutNotificationsVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;


@Repository
@RequiredArgsConstructor
public class PushDaoImpl implements PushDao {

    private final PushMemberJpaRepository pushMemberJpaRepository;
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
    public OutNotificationsVo findAllByPushDayAndPushTime(PushNotificationVo vo) {

        return OutNotificationsVo
                .builder()
                .pushNotifications(
                        pushNotificationsJpaRepository.findByPushDayAndHourAndMinute(vo.getPushDay(), vo.getHour(), vo.getMinute())
                )
                .build();
    }

    @Override
    public void registPushNotification(PushNotification pushNotification) {

        pushNotificationsJpaRepository.save(pushNotification);

    }

    public PushMember findByMemberId(Long memberId) {
        return pushMemberJpaRepository
                .findByMemberId(memberId)
                .orElseThrow(() -> new IllegalArgumentException("사용자를 찾을 수 없습니다."));
    }


}
