package com.ssafy.yourpilling.pill.model.dao.entity;

import lombok.*;

import java.time.LocalDate;

@Getter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class MonthlyTakerHistory {

    private LocalDate takeAt;
    private String name;
    private Integer currentTakeCount;
    private Integer needToTakeCount;

}
