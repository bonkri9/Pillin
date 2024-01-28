package com.ssafy.yourpilling.pill.model.service.vo.out;

import com.ssafy.yourpilling.pill.model.dao.entity.WeeklyHistoryInterface;
import lombok.Builder;
import lombok.Value;

import java.util.List;

@Value
@Builder
public class OutWeeklyTakerHistoryVo {

    List<WeeklyHistoryInterface> data;

}
