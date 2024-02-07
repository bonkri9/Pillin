package com.ssafy.yourpilling.analysis.controller.mapper;

import com.ssafy.yourpilling.analysis.model.service.vo.in.AnalysisVo;
import org.springframework.stereotype.Component;

@Component
public class AnalysisControllerMapper {
    public AnalysisVo mapToAnalysisVo (Long memberId){
        return AnalysisVo.builder()
                .id(memberId)
                .build();
    }
}
