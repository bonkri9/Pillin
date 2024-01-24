package com.ssafy.yourpilling.pill.model.service.vo.response;

import lombok.Builder;
import lombok.Value;

import java.time.LocalDate;
import java.util.List;

@Value
@Builder
public class ResponsePillInventorListVo {

    ResponsePillInventorListData takeTrue;
    ResponsePillInventorListData takeFalse;

    @Value
    @Builder
    public static class ResponsePillInventorListData {
        List<ResponsePillInventoryItem> data;
    }

    @Value
    @Builder
    public static class ResponsePillInventoryItem {
        String imageURl;
        Integer totalCount;
        Integer remains;
        LocalDate predicateRunOutAt;
    }
}
