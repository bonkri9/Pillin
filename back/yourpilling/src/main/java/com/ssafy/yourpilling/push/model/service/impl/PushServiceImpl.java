package com.ssafy.yourpilling.push.model.service.impl;

import com.ssafy.yourpilling.push.model.dao.PushDao;
import com.ssafy.yourpilling.push.model.dao.entity.PushMember;
import com.ssafy.yourpilling.push.model.dao.entity.PushMessageInfo;
import com.ssafy.yourpilling.push.model.dao.entity.PushNotification;
import com.ssafy.yourpilling.push.model.dao.entity.PushOwnPill;
import com.ssafy.yourpilling.push.model.service.PushService;
import com.ssafy.yourpilling.push.model.service.mapper.PushServiceMapper;
import com.ssafy.yourpilling.push.model.service.vo.in.*;
import com.ssafy.yourpilling.push.model.service.vo.out.OutNotificationsVo;
import com.ssafy.yourpilling.push.model.service.vo.out.OutPushMessageInfoMapVo;
import com.ssafy.yourpilling.push.model.service.vo.out.OutPushMessageInfoVo;
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

    @Override
    public void updatePushNotification(UpdatePushNotificationVo vo) {
        Boolean[] days = vo.getDay();
        for(int day=0; day<days.length; day++) {
            if(days[day]) {
//                pushDao.registPushNotification(mapper.mapToPushNotification(day+1, vo, pushDao.findByMemberId(vo.getMemberId())));
            }
        }
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
