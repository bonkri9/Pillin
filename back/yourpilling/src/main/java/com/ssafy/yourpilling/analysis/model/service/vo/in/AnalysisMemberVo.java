package com.ssafy.yourpilling.analysis.model.service.vo.in;

import com.ssafy.yourpilling.common.AgeGroup;
import com.ssafy.yourpilling.common.Gender;
import lombok.Builder;
import lombok.Value;

import java.time.LocalDate;

@Value
@Builder
public class AnalysisMemberVo {
    Long id;
    Gender gender;
    String ageGroup;
}
