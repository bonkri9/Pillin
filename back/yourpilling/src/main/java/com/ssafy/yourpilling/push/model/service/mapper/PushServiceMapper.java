package com.ssafy.yourpilling.push.model.service.mapper;

import com.ssafy.yourpilling.push.model.dao.entity.DeviceToken;
import com.ssafy.yourpilling.push.model.dao.entity.PushMember;
import com.ssafy.yourpilling.push.model.dao.entity.PushOwnPill;
import com.ssafy.yourpilling.push.model.service.vo.in.DeviceTokenVo;
import com.ssafy.yourpilling.push.model.service.vo.out.OutDeviceTokenVo;
import com.ssafy.yourpilling.push.model.service.vo.out.OutPushRepurchaseVo;
import com.ssafy.yourpilling.push.model.service.vo.out.PushMemberVo;
import com.ssafy.yourpilling.push.model.service.vo.out.PushOwnPillVo;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;


@Component
public class PushServiceMapper {

    public DeviceToken mapToDeviceToken(DeviceTokenVo deviceTokenVo) {

        return DeviceToken
                .builder()
                .deviceToken(deviceTokenVo.getDeviceToken())
                .member(PushMember.builder().memberId(deviceTokenVo.getMemberId()).build())
                .build();

    }


    public OutPushRepurchaseVo mapToPushMemberVo(List<PushMember> allPushMember) {

        List<PushMemberVo> pushMemberVoList = new ArrayList<>();


        for(PushMember pm : allPushMember) {

            List<OutDeviceTokenVo> deviceTokenVoList = new ArrayList<>();
            List<PushOwnPillVo> pushOwnPillVoList = new ArrayList<>();

            for(DeviceToken deviceToken : pm.getDeviceTokens()) {
                deviceTokenVoList.add(OutDeviceTokenVo.builder().deviceToken(deviceToken.getDeviceToken()).build());
            }

            for(PushOwnPill pushOwnPill : pm.getOwnPills()) {
                pushOwnPillVoList.add(mapToPushOwnPillVo(pushOwnPill));
            }

            pushMemberVoList.add(mapToPushMemberVo(deviceTokenVoList, pushOwnPillVoList));

        }


        return OutPushRepurchaseVo.builder().pushMemberVoList(pushMemberVoList).build();
    }

    private PushMemberVo mapToPushMemberVo(List<OutDeviceTokenVo> deviceTokenVoList, List<PushOwnPillVo> pushOwnPillVoList) {

        return PushMemberVo
                .builder()
                .deviceTokenVos(deviceTokenVoList)
                .ownPillVos(pushOwnPillVoList)
                .build();

    }

    private PushOwnPillVo mapToPushOwnPillVo(PushOwnPill pushOwnPill) {
        return PushOwnPillVo
                .builder()
                .ownPillId(pushOwnPill.getOwnPillId())
                .remains(pushOwnPill.getRemains())
                .takeYN(pushOwnPill.getTakeYN())
                .totalCount(pushOwnPill.getTotalCount())
                .build();
    }
}
