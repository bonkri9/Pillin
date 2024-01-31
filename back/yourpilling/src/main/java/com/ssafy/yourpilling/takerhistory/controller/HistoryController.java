package com.ssafy.yourpilling.takerhistory.controller;

import com.ssafy.yourpilling.security.auth.PrincipalDetails;
import com.ssafy.yourpilling.takerhistory.controller.dto.request.RequestDailyHistoryDto;
import com.ssafy.yourpilling.takerhistory.controller.mapper.HistoryControllerMapper;
import com.ssafy.yourpilling.takerhistory.model.service.TakerHistoryService;
import com.ssafy.yourpilling.takerhistory.model.service.vo.in.DailyHistoryVo;
import com.ssafy.yourpilling.takerhistory.model.service.vo.out.wrapper.OutDailyHistoryVos;
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

    private final TakerHistoryService takerHistoryService;
    private final HistoryControllerMapper mapper;

    @GetMapping("/daily")
    ResponseEntity<OutDailyHistoryVos> dailyList(@AuthenticationPrincipal PrincipalDetails principalDetails,
                                                 @RequestBody RequestDailyHistoryDto requestDailyHistoryDto){
        DailyHistoryVo dailyHistoryVo = mapper.mapToMemberRegisterVo(requestDailyHistoryDto, principalDetails.getMember().getMemberId());
        OutDailyHistoryVos data = takerHistoryService.findByTakeAtAndMemberId(dailyHistoryVo);
        return ResponseEntity.ok(data);
    }

}