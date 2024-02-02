package com.ssafy.yourpilling.pill.model.service.vo.out;

import lombok.Builder;
import lombok.Value;

import java.time.LocalDate;
import java.util.List;

@Value
@Builder
public class OutOwnPillDetailVo {
    Long ownPillId;
    Integer remains;
    Integer totalCount;
    List<String> takeWeekdays;
    Integer takeCount;
    Integer takeOnceAmount;
    Boolean isAlarm;
    Boolean takeYn;
    LocalDate startAt;
    String warningMessage;
    OutOwnPillPillDetailVo pill;

    @Value
    @Builder
    public static class OutOwnPillPillDetailVo{
        Long pillId;
        String name;
        String manufacturer;
        String expirationAt;
        String usageInstructions;
        String primaryFunctionality;
        String precautions;
        String storageInstructions;
        String standardSpecification;
        String productForm;
        String imageUrl;
    }
}
