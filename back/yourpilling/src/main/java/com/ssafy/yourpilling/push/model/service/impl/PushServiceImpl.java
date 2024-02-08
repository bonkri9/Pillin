package com.ssafy.yourpilling.push.model.service.impl;

import com.ssafy.yourpilling.push.model.dao.PushDao;
import com.ssafy.yourpilling.push.model.dao.entity.PushMember;
import com.ssafy.yourpilling.push.model.dao.entity.PushMessageInfo;
import com.ssafy.yourpilling.push.model.dao.entity.PushNotification;
import com.ssafy.yourpilling.push.model.dao.entity.PushOwnPill;
import com.ssafy.yourpilling.push.model.service.PushService;
import com.ssafy.yourpilling.push.model.service.mapper.PushServiceMapper;
import com.ssafy.yourpilling.push.model.service.vo.in.*;
import com.ssafy.yourpilling.push.model.service.vo.in.DeviceTokenVo;
import com.ssafy.yourpilling.push.model.service.vo.out.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class PushServiceImpl implements PushService {

    private final PushDao pushDao;
    private final PushServiceMapper mapper;

    @Transactional
    @Override
    public void register(DeviceTokenVo deviceTokenVo) {

        pushDao.tokenRegister(mapper.mapToDeviceToken(deviceTokenVo));

    }

    @Override
    public OutNotificationsVo findAllByPushDayAndPushTime(PushNotificationVo vo) {
        return pushDao.findAllByPushDayAndPushTime(vo);
    }

    @Transactional
    @Override
    public void registPushNotification(RegistPushNotificationVo vo) {
        pushDao.registPushNotification(vo);
    }

    @Transactional
    @Override
    public void updatePushNotification(UpdatePushNotificationVo vo) {

        if(timeInvalid(vo)) throw new IllegalArgumentException("잘못된 시간 정보입니다.");
        pushDao.updatePushNotification(vo);

    }

    private boolean timeInvalid(UpdatePushNotificationVo vo) {
        return vo.getHour() > 24 || vo.getHour() < 0 || vo.getMinute() > 60 || vo.getMinute() < 0;
    }

    @Transactional
    @Override
    public void DeletePushNotification(DeletePushNotificationsVo vo) {
        pushDao.deletePushNotificationById(vo);
    }

    @Override
    public OutPushMessageInfoMapVo selectPushNotification(Long memberId) {

        List<HashMap<Long, OutPushMessageInfoVo>> data = new ArrayList<>();

        PushMember member = pushDao.findByMemberId(memberId);
        for(PushOwnPill op : member.getOwnPills()) {
            for(PushNotification notification : op.getPushNotifications()){

                Boolean[] days = new Boolean[7];
                Arrays.fill(days, false);
                for(PushMessageInfo info : notification.getMessageInfos()) {
                    days[info.getPushDay() - 1] = true;
                }

                HashMap<Long, OutPushMessageInfoVo> ownPillIdToMessageVo = new HashMap<>();

                OutPushMessageInfoVo vo = getOutPushMessageInfoVo(notification, days);
                ownPillIdToMessageVo.put(op.getOwnPillId(), vo);
                data.add(ownPillIdToMessageVo);
            }
        }

        return OutPushMessageInfoMapVo.builder().data(data).build();
    }

    @Override
    public OutPushRepurchaseVo findByOutRemains() {
        return mapper.mapToPushMemberVo(pushDao.findAllPushMember());
    }

    private OutPushMessageInfoVo getOutPushMessageInfoVo(PushNotification notification, Boolean[] days) {
        return OutPushMessageInfoVo
                .builder()
                .ownPillName(notification.getPushOwnPill().getPushPill().getName())
                .pushId(notification.getPushId())
                .hour(notification.getPushHour())
                .minute(notification.getPushMinute())
                .days(days)
                .build();
    }


}
