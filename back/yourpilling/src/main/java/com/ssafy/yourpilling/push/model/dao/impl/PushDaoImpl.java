package com.ssafy.yourpilling.push.model.dao.impl;

import com.ssafy.yourpilling.push.model.dao.PushDao;
import com.ssafy.yourpilling.push.model.dao.entity.DeviceToken;
import com.ssafy.yourpilling.push.model.dao.entity.PushMember;
import com.ssafy.yourpilling.push.model.dao.entity.PushMessageInfo;
import com.ssafy.yourpilling.push.model.dao.entity.PushNotification;
import com.ssafy.yourpilling.push.model.dao.jpa.DeviceTokenJpaRepository;
import com.ssafy.yourpilling.push.model.dao.jpa.PushMemberJpaRepository;
import com.ssafy.yourpilling.push.model.dao.jpa.PushMessageInfoJpaRepository;
import com.ssafy.yourpilling.push.model.dao.jpa.PushNotificationsJpaRepository;
import com.ssafy.yourpilling.push.model.service.vo.in.DeletePushNotificationsVo;
import com.ssafy.yourpilling.push.model.service.vo.in.PushNotificationVo;
import com.ssafy.yourpilling.push.model.service.vo.in.RegistPushNotificationVo;
import com.ssafy.yourpilling.push.model.service.vo.out.OutNotificationsVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;


@Repository
@RequiredArgsConstructor
public class PushDaoImpl implements PushDao {

    private final PushMemberJpaRepository pushMemberJpaRepository;
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

        return OutNotificationsVo
                .builder()
                .pushMessageInfos(
                        pushMessageInfoJpaRepository.findByPushDayAndPushHourAndPushMinute(vo.getPushDay(), vo.getHour(), vo.getMinute())
                )
                .build();
    }

    @Override
    public void registPushNotification(RegistPushNotificationVo vo) {

        PushNotification pushNotification = PushNotification
                .builder()
                .member(findByMemberId(vo.getMemberId()))
                .messageInfos(new ArrayList<>())
                .message(vo.getMessage())
                .build();

        Boolean[] days = vo.getDay();
        for(int day=0; day<days.length; day++) {
            if(days[day]) {
                pushNotification.addMessageInfo(
                        PushMessageInfo
                        .builder()
                        .pushNotification(pushNotification)
                        .pushHour(vo.getHour())
                        .pushMinute(vo.getMinute())
                        .pushDay(day+1)
                        .build()
                );
            }
        }

        pushNotificationsJpaRepository.save(pushNotification);

    }

    public PushMember findByMemberId(Long memberId) {
        return pushMemberJpaRepository
                .findByMemberId(memberId)
                .orElseThrow(() -> new IllegalArgumentException("사용자를 찾을 수 없습니다."));
    }

    @Override
    public void deletePushNotificationById(DeletePushNotificationsVo vo) {
        pushNotificationsJpaRepository.deleteByPushId(vo.getPushId());
    }


}
