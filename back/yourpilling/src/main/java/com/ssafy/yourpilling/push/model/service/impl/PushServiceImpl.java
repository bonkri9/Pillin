package com.ssafy.yourpilling.push.model.service.impl;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import com.ssafy.yourpilling.push.controller.dto.request.RequestPushFcmDto;
import com.ssafy.yourpilling.push.controller.mapper.PushControllerMapper;
import com.ssafy.yourpilling.push.model.dao.PushDao;
import com.ssafy.yourpilling.push.model.dao.entity.*;
import com.ssafy.yourpilling.push.model.service.PushService;
import com.ssafy.yourpilling.push.model.service.mapper.PushServiceMapper;
import com.ssafy.yourpilling.push.model.service.vo.in.*;
import com.ssafy.yourpilling.push.model.service.vo.in.DeviceTokenVo;
import com.ssafy.yourpilling.push.model.service.vo.out.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.*;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class PushServiceImpl implements PushService {

    private final PushDao pushDao;
    private final PushServiceMapper mapper;
    private final FirebaseMessaging firebaseMessaging;
    private final PushControllerMapper controllerMapper;
    private final String PUSH_TITLE = "Pillin";
    private final String PUSH_IMAGE = "https://www.google.com/url?sa=i&url=https%3A%2F%2Fpixabay.com%2Fko%2Fimages%2Fsearch%2F%25EC%2598%2581%25EC%2596%2591%25EC%25A0%259C%2F&psig=AOvVaw2J4FYwok9I3UwNP5WIPR-_&ust=1706684262130000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCNiij7vEhIQDFQAAAAAdAAAAABAE";
    private final String REPURCHASE_PUSH_MESSAGE = "재구매 시기가 다가온 영양제가 있습니다!";
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

    @Override
    public void sendFCM() {
        LocalDateTime now = LocalDateTime.now();

        RequestPushFcmDto dto = RequestPushFcmDto
                .builder()
                .pushDay(now.getDayOfWeek().getValue())
                .hour(now.getHour())
                .minute(now.getMinute())
                .build();

        OutNotificationsVo vo = findAllByPushDayAndPushTime(controllerMapper.mapToPushNotificationsVo(dto));

        for (PushNotification noti : vo.getPushNotifications()) {
            if (noti.getPushOwnPill().getMember().getDeviceTokens() == null) {
                System.err.println("디바이스 토큰이 존재하지 않습니다!");
                continue;
            }
            for (DeviceToken deviceToken : noti.getPushOwnPill().getMember().getDeviceTokens()) {

                Message fcmMessage = Message
                        .builder()
                        .setNotification(getNotification(noti.getMessage()))
                        .setToken(deviceToken.getDeviceToken())
                        .build();

                try {
                    firebaseMessaging.send(fcmMessage);
                } catch (FirebaseMessagingException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    @Override
    public void sendRepurchaseFCM() {
        OutPushRepurchaseVo outPushRepurchaseVo = findByOutRemains();

        List<OutDeviceTokenVo> sendDeviceList = new ArrayList<>();

        // 부족한 재고 정보와 누구에게 보낼지(DeviceToken)을 조회
        for (PushMemberVo pm : outPushRepurchaseVo.getPushMemberVoList()) {
            for (PushOwnPillVo op : pm.getOwnPillVos()) {
                if (op.getRemains() / (double) op.getTotalCount() < 0.2) {
                    sendDeviceList.addAll(pm.getDeviceTokenVos());
                    break;
                }
            }
        }

        // DeviceToken에 해당되는 유저에게 부족하다는 메세지를 보내야함

        for (OutDeviceTokenVo dt : sendDeviceList) {
            if (dt.getDeviceToken() == null) {
                System.err.println("디바이스 토큰이 존재하지 않습니다!");
                continue;
            }

            Message fcmMessage = Message
                    .builder()
                    .setNotification(getNotification(REPURCHASE_PUSH_MESSAGE))
                    .setToken(dt.getDeviceToken())
                    .build();

            try {
                firebaseMessaging.send(fcmMessage);
            } catch (FirebaseMessagingException e) {
                e.printStackTrace();
            }
        }
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

    private Notification getNotification(String message) {
        return Notification
                .builder()
                .setTitle(PUSH_TITLE)
                .setBody(message)
                .setImage(PUSH_IMAGE)
                .build();
    }

}
