package com.ssafy.yourpilling.pill_heeju.model.service.vo.response;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class ResponsePillSearchDataVo {
    Long pillId;
    String pillName;
    String manufacturer;
    String imageUrl;
}