package com.ssafy.yourpilling.pill.model.service.dto;

import com.ssafy.yourpilling.pill.model.dao.entity.MonthlyTakerHistory;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TakerHistorySummary {

    int needToTakenCountTheDay;
    int actualTakenCountTheDay;
    List<MonthlyTakerHistory> taken;

    public void increaseNeedToTakenCount(int val) {
        this.needToTakenCountTheDay += val;
    }

    public void increaseActualTakenCount(int val) {
        this.actualTakenCountTheDay += val;
    }

    public void addTakerHistory(MonthlyTakerHistory mth) {
        this.taken.add(mth);
    }

}
