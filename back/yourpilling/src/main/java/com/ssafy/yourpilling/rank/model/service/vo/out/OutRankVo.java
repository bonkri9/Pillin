package com.ssafy.yourpilling.rank.model.service.vo.out;

import lombok.Builder;
import lombok.ToString;
import lombok.Value;

import java.util.List;

@Value
@Builder
@ToString
public class OutRankVo {

    Long midCategoryId;
    String midCategoryName;
    List<OutRankData> outRankData;

    @Value
    @Builder
    @ToString
    public static class OutRankData {
        Long pillId;
        String pillName;
        Integer rank;
        String manufacturer;
        String imageUrl;
    }
}
