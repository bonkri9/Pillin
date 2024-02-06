package com.ssafy.yourpilling.analysis.controller;

import com.ssafy.yourpilling.analysis.model.service.AnalysisService;
import com.ssafy.yourpilling.analysis.model.service.vo.out.OutAnalysisVo;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/pill")
public class AnalysisController {
    private final AnalysisService analysisService;

    @GetMapping("/analysis")
    ResponseEntity<OutAnalysisVo> analysis(@RequestParam(name ="id")Long id){
        OutAnalysisVo data = analysisService.analysis(id);
        return ResponseEntity.ok(data);
    }

}
