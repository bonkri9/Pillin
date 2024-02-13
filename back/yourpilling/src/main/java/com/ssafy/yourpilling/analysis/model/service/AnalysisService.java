package com.ssafy.yourpilling.analysis.model.service;

import com.ssafy.yourpilling.analysis.model.service.vo.in.AnalysisVo;
import com.ssafy.yourpilling.analysis.model.service.vo.out.OutAnalysisVo;

public interface AnalysisService {
    OutAnalysisVo analysis(AnalysisVo vo);
}
