package com.ssafy.yourpilling.push.model.service.impl;

import com.ssafy.yourpilling.push.model.dao.PushDao;
import com.ssafy.yourpilling.push.model.service.PushService;
import com.ssafy.yourpilling.push.model.service.mapper.PushServiceMapper;
import com.ssafy.yourpilling.push.model.service.vo.in.DeviceTokenVo;
import com.ssafy.yourpilling.push.model.service.vo.in.PushNotificationsVo;
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
    public void registToken(DeviceTokenVo deviceTokenVo) {

        pushDao.tokenRegister(mapper.mapToDeviceToken(deviceTokenVo));

    }



    @Override
    public OutNotificationsVo findAllByPushDayAndPushTime(PushNotificationsVo vo) {
        return pushDao.findAllByPushDayAndPushTime(vo);
    }

    @Transactional
    @Override
    public void deleteToken(DeviceTokenVo deviceTokenVo) {
        pushDao.deleteByMemberIdAndDeviceToken(deviceTokenVo);
    }


}
