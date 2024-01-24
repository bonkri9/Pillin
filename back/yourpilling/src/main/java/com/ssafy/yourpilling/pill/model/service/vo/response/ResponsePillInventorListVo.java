package com.ssafy.yourpilling.pill.model.service.vo.response;

import lombok.Data;

import java.time.LocalDate;
import java.util.List;

@Data
public class ResponsePillInventorListVo {

    private ResponsePillInventorListData takeTrue;
    private ResponsePillInventorListData takeFalse;

    @Data
    public static class ResponsePillInventorListData {
        private List<ResponsePillInventoryItem> data;
    }

    @Data
    public static class ResponsePillInventoryItem {
        private String imageURl;
        private Integer totalCount;
        private Integer remains;
        private LocalDate predicateRunOut;
        private LocalDate predicateBuy;
    }
}
