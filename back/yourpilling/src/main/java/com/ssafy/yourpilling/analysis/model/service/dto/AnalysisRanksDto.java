package com.ssafy.yourpilling.analysis.model.service.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Builder
@AllArgsConstructor
@Getter
public class AnalysisRanksDto {
    Integer rank;
    Integer weeks;
    String categoryNm;
    String pillName;
    Long pillId;
    String manufacturer;
    String imgUrl;
}
