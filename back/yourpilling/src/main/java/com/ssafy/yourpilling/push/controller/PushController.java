package com.ssafy.yourpilling.push.controller;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import com.ssafy.yourpilling.push.controller.dto.request.*;
import com.ssafy.yourpilling.push.controller.mapper.PushControllerMapper;
import com.ssafy.yourpilling.push.model.dao.entity.DeviceToken;
import com.ssafy.yourpilling.push.model.dao.entity.PushNotification;
import com.ssafy.yourpilling.push.model.service.PushService;
import com.ssafy.yourpilling.push.model.service.vo.out.*;
import com.ssafy.yourpilling.security.auth.PrincipalDetails;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/v1/push")
public class PushController {

    private final String PUSH_TITLE = "Pillin";
    private final String PUSH_IMAGE = "https://www.google.com/url?sa=i&url=https%3A%2F%2Fpixabay.com%2Fko%2Fimages%2Fsearch%2F%25EC%2598%2581%25EC%2596%2591%25EC%25A0%259C%2F&psig=AOvVaw2J4FYwok9I3UwNP5WIPR-_&ust=1706684262130000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCNiij7vEhIQDFQAAAAAdAAAAABAE";
    private final String REPURCHASE_PUSH_MESSAGE = "재구매 시기가 다가온 영양제가 있습니다!";
    private final PushService pushService;
    private final PushControllerMapper mapper;
    private final FirebaseMessaging firebaseMessaging;

    @PostMapping("/device-token")
    ResponseEntity<Void> register(@AuthenticationPrincipal PrincipalDetails principalDetails,
                                  @RequestBody RequestDeviceTokenDto dto) {
        log.info("[요청 : 디바이스 토큰 등록] member_id : {}, deviceToken : {}", principalDetails.getMember().getMemberId(), dto.getDeviceToken());
        pushService.register(mapper.mapToDeviceTokenVo(principalDetails.getMember().getMemberId(), dto));
        return ResponseEntity.ok().build();
    }

    @GetMapping("/notification")
    ResponseEntity<OutPushMessageInfoMapVo> selectPushNotifications(@AuthenticationPrincipal PrincipalDetails principalDetails) {
        log.info("[요청 : PUSH알림 정보 목록 조회] member_id : {},", principalDetails.getMember().getMemberId());
        OutPushMessageInfoMapVo vo = pushService.selectPushNotification(principalDetails.getMember().getMemberId());
        return ResponseEntity.ok(vo);
    }

    @PostMapping("/notification")
    ResponseEntity<Void> registPushNotification(@RequestBody RequestPushNotificationsDto dto) {
        log.info("[요청 : PUSH알림 정보 등록] ownPillId : {}, ownPillName : {}, day : {}, hour : {}, minute : {}, ", dto.getOwnPillId(), dto.getOwnPillName(), dto.getDay(), dto.getHour(), dto.getMinute());
        pushService.registPushNotification(mapper.mapToRegistPushNotificationVo(dto));
        return ResponseEntity.ok().build();
    }

    @PutMapping("/notification")
    ResponseEntity<Void> updatePushNotification(@AuthenticationPrincipal PrincipalDetails principalDetails,
                                                @RequestBody RequestUpdatePushNotificationDto dto) {
        log.info("[요청 : PUSH알림 정보 수정] pushId : {}, day : {}, hour : {}, minute : {}, ", dto.getPushId(), dto.getDay(), dto.getHour(), dto.getMinute());
        pushService.updatePushNotification(mapper.mapToUpdatePushNotificationVo(principalDetails.getMember().getMemberId(), dto));
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/notification")
    ResponseEntity<Void> deletePushNotification(@AuthenticationPrincipal PrincipalDetails principalDetails,
                                                @RequestBody RequestDeletePushNotificationsDto dto) {
        log.info("[요청 : PUSH알림 정보 삭제] pushId : {} ", dto.getPushId());
        pushService.DeletePushNotification(mapper.mapToDeletePushNotificationVo(principalDetails.getMember().getMemberId(), dto));
        return ResponseEntity.ok().build();
    }

    @Scheduled(cron = "0 */1 * * * *")
    ResponseEntity<Void> sendPushMessage() {
        log.info("[요청 : PUSH 복용 메세지 FCM 스케쥴러 동작]");
        pushService.sendFCM();
        return ResponseEntity.ok().build();
    }

    @Scheduled(cron = "0 0 20 * * *")
    ResponseEntity<Void> sendPushRepurchaseMessage() {

        log.info("[요청 : PUSH 재구매 메세지 FCM 스케쥴러 동작]");
        pushService.sendRepurchaseFCM();
        return ResponseEntity.ok().build();
    }

    @GetMapping("/send-pushMessageTest")
    ResponseEntity<Void> sendPushMessageTest(@RequestParam(name = "deviceToken") String deviceToken) {
        log.info("[요청 : PUSH 메세지 FCM 테스트] deviceToken : {}", deviceToken);
        Message fcmMessage = Message
                .builder()
                .setNotification(
                        Notification
                                .builder()
                                .setTitle(PUSH_TITLE)
                                .setBody("다 떨어져가는 영양제가 있어요!")
                                .setImage(PUSH_IMAGE)
                                .build()
                )
                .setToken(deviceToken)
                .build();
        try {
            firebaseMessaging.send(fcmMessage);
        } catch (FirebaseMessagingException e) {
            e.printStackTrace();
        }

        return ResponseEntity.ok().build();
    }
}
