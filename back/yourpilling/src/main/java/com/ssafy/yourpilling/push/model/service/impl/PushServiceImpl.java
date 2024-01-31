package com.ssafy.yourpilling.push.model.service.impl;

import com.ssafy.yourpilling.push.model.dao.PushDao;
import com.ssafy.yourpilling.push.model.service.PushService;
import com.ssafy.yourpilling.push.model.service.mapper.PushServiceMapper;
import com.ssafy.yourpilling.push.model.service.vo.in.*;
import com.ssafy.yourpilling.push.model.service.vo.out.OutNotificationsVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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


}
