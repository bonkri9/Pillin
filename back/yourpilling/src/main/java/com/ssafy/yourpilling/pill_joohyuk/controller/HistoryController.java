package com.ssafy.yourpilling.pill_joohyuk.controller;

import com.ssafy.yourpilling.pill_joohyuk.controller.dto.request.RequestDailyHistoryDto;
import com.ssafy.yourpilling.pill_joohyuk.controller.mapper.HistoryControllerMapper;
import com.ssafy.yourpilling.pill_joohyuk.model.service.JHistoryService;
import com.ssafy.yourpilling.pill_joohyuk.model.service.vo.in.JDailyHistoryVo;
import com.ssafy.yourpilling.pill_joohyuk.model.service.vo.out.wrapper.JResponseDailyHistoryVos;
import com.ssafy.yourpilling.security.auth.PrincipalDetails;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/history")
public class HistoryController {

    private final JHistoryService historyService;
    private final HistoryControllerMapper mapper;

    @GetMapping("/daily")
    ResponseEntity<JResponseDailyHistoryVos> dailyList(@AuthenticationPrincipal PrincipalDetails principalDetails, @RequestBody RequestDailyHistoryDto requestDailyHistoryDto){
        JDailyHistoryVo dailyHistoryVo = mapper.mapToMemberRegisterVo(requestDailyHistoryDto, principalDetails.getMember().getMemberId());
        JResponseDailyHistoryVos data = historyService.findByTakeAtAndMemberId(dailyHistoryVo);
        return ResponseEntity.ok(data);
    }

}
