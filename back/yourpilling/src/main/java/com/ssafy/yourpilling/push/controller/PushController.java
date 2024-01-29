package com.ssafy.yourpilling.push.controller;

import com.ssafy.yourpilling.push.controller.dto.request.RequestDeviceTokenDto;
import com.ssafy.yourpilling.push.controller.mapper.PushControllerMapper;
import com.ssafy.yourpilling.push.model.service.PushService;
import com.ssafy.yourpilling.security.auth.PrincipalDetails;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/push")
public class PushController {

    private final PushControllerMapper mapper;
    private final PushService pushService;

    @PostMapping("/device-token")
    ResponseEntity<Void> register(@AuthenticationPrincipal PrincipalDetails principalDetails,
                                  @RequestBody RequestDeviceTokenDto dto) {
        pushService.register(mapper.mapToDeviceTokenVo(principalDetails.getMember().getMemberId(), dto));
        return ResponseEntity.ok().build();
    }
}
