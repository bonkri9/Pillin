package com.ssafy.yourpilling.pill_heeju.model.service.vo.out;

import lombok.Builder;
import lombok.Value;

import java.util.List;

@Value
@Builder
public class ResponsePillSearchListVo {

    @Value
    @Builder
    public static class ResponsePillSearchListData {
        List<ResponsePillSearchItem> data;
    }

    @Value
    @Builder
    public static class ResponsePillSearchItem{
        Long pillId;
        String pillName;
        String manufacturer;
        String imageUrl;
    }
}