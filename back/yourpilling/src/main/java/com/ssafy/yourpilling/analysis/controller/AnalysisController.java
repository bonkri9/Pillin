package com.ssafy.yourpilling.analysis.controller;

import com.ssafy.yourpilling.analysis.controller.mapper.AnalysisControllerMapper;
import com.ssafy.yourpilling.analysis.model.service.AnalysisService;
import com.ssafy.yourpilling.analysis.model.service.vo.out.OutAnalysisVo;
import com.ssafy.yourpilling.security.auth.PrincipalDetails;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/pill")
public class AnalysisController {
    private final AnalysisService analysisService;
    private final AnalysisControllerMapper mapper;

    @GetMapping("/analysis")
    ResponseEntity<OutAnalysisVo> analysis(@AuthenticationPrincipal PrincipalDetails principalDetails){
        OutAnalysisVo data = analysisService.analysis(mapper.mapToAnalysisVo(principalDetails.getMember().getMemberId()));
        return ResponseEntity.ok(data);
    }

}
