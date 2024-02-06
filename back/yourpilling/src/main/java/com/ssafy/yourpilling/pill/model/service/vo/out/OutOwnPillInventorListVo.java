package com.ssafy.yourpilling.pill.model.service.vo.out;

import lombok.Builder;
import lombok.Value;

import java.time.LocalDate;
import java.util.List;

@Value
@Builder
public class OutOwnPillInventorListVo {

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
        Long ownPillId;
        String imageUrl;
        Integer totalCount;
        Integer remains;
        LocalDate predicateRunOutAt;
    }
}
