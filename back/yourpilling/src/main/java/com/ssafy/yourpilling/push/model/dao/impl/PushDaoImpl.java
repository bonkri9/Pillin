package com.ssafy.yourpilling.push.model.dao.impl;

import com.ssafy.yourpilling.push.model.dao.PushDao;
import com.ssafy.yourpilling.push.model.dao.entity.*;
import com.ssafy.yourpilling.push.model.dao.jpa.*;
import com.ssafy.yourpilling.push.model.service.vo.in.DeletePushNotificationsVo;
import com.ssafy.yourpilling.push.model.service.vo.in.PushNotificationVo;
import com.ssafy.yourpilling.push.model.service.vo.in.RegistPushNotificationVo;
import com.ssafy.yourpilling.push.model.service.vo.in.UpdatePushNotificationVo;
import com.ssafy.yourpilling.push.model.service.vo.out.OutNotificationsVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;


@Repository
@RequiredArgsConstructor
public class PushDaoImpl implements PushDao {

    private final PushMemberJpaRepository pushMemberJpaRepository;
    private final PushOwnPillJpaRepository pushOwnPillJpaRepository;
    private final DeviceTokenJpaRepository deviceTokenJpaRepository;
    private final PushMessageInfoJpaRepository pushMessageInfoJpaRepository;
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

        List<PushNotification> list = pushNotificationsJpaRepository.findByPushTimeAndDay(vo.getHour(), vo.getMinute(), vo.getPushDay());

        return OutNotificationsVo
                .builder()
                .pushNotifications(list)
                .build();
    }

    @Override
    public void registPushNotification(RegistPushNotificationVo vo) {

        PushNotification pushNotification = PushNotification
                .builder()
                .pushOwnPill(findOwnPill(vo.getOwnPillId()))
                .messageInfos(new ArrayList<>())
                .message(vo.getMessage())
                .pushHour(vo.getHour())
                .pushMinute(vo.getMinute())
                .build();

        Boolean[] days = vo.getDay();
        for (int day = 0; day < days.length; day++) {
            if (days[day]) {
                pushNotification.addMessageInfo(buildPushMessageInfo(pushNotification, day));
            }
        }

        pushNotificationsJpaRepository.save(pushNotification);

    }


    private PushOwnPill findOwnPill(Long ownPillId) {
        return pushOwnPillJpaRepository.findById(ownPillId)
                .orElseThrow(() -> new IllegalArgumentException("잘못된 보유 영양제 ID입니다."));
    }

    public PushMember findByMemberId(Long memberId) {
        return pushMemberJpaRepository
                .findByMemberId(memberId)
                .orElseThrow(() -> new IllegalArgumentException("사용자를 찾을 수 없습니다."));
    }

    public List<PushMember> findAllPushMember() {
        return pushMemberJpaRepository
                .findAll();
    }

    @Override
    public void deletePushNotificationById(DeletePushNotificationsVo vo) {
        pushNotificationsJpaRepository.deleteByPushId(vo.getPushId());
    }

    @Override
    public void updatePushNotification(UpdatePushNotificationVo vo) {

        PushNotification pushNotification = pushNotificationsJpaRepository
                .findById(vo.getPushId())
                .orElseThrow(() -> new IllegalArgumentException("푸시ID가 잘못되었습니다."));


        pushMessageInfoJpaRepository.deleteAllByPushNotificationPushId(pushNotification.getPushId());
        pushNotification.getMessageInfos().clear();


        Boolean[] days = vo.getDay();
        for (int day = 0; day < days.length; day++) {
            if (days[day]) {
                pushNotification.addMessageInfo(buildPushMessageInfo(pushNotification, day));
            }
        }

        pushNotification.setPushHour(vo.getHour());
        pushNotification.setPushMinute(vo.getMinute());

        pushNotificationsJpaRepository.save(pushNotification);

    }


    private PushMessageInfo buildPushMessageInfo(PushNotification pushNotification, int day) {
        return PushMessageInfo
                .builder()
                .pushNotification(pushNotification)
                .pushDay(day + 1)
                .build();
    }


}
