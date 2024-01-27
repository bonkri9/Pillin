package com.ssafy.yourpilling.pill_joohyuk.model.service.impl;

import com.ssafy.yourpilling.pill_joohyuk.model.dao.JHistoryDao;
import com.ssafy.yourpilling.pill_joohyuk.model.dao.entity.JTakerHistory;
import com.ssafy.yourpilling.pill_joohyuk.model.service.JHistoryService;
import com.ssafy.yourpilling.pill_joohyuk.model.service.mapper.JHistoryMapper;
import com.ssafy.yourpilling.pill_joohyuk.model.service.vo.in.JDailyHistoryVo;
import com.ssafy.yourpilling.pill_joohyuk.model.service.vo.out.JResponseDailyHistoryVo;
import com.ssafy.yourpilling.pill_joohyuk.model.service.vo.out.wrapper.JResponseDailyHistoryVos;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class JHistoryServiceImpl implements JHistoryService {

    private final JHistoryDao historyDao;
    private final JHistoryMapper takerHistoryMapper;

    public JResponseDailyHistoryVos findByTakeAtAndMemberId(JDailyHistoryVo dailyHistoryVo) {
        List<JTakerHistory> dailyHistories = historyDao.findByTakeAtAndMemberId(dailyHistoryVo.getTakeAt(), dailyHistoryVo.getMemberId());
        List<JResponseDailyHistoryVo> responses = new ArrayList<>();

        for (JTakerHistory dailyHistory : dailyHistories) {
            boolean isTake = dailyHistory.getNeedToTakeCount().equals(dailyHistory.getCurrentTakeCount());

            responses.add(takerHistoryMapper.mapToResponseDailyHistoryVo(dailyHistory, isTake));
        }

        return new JResponseDailyHistoryVos(responses);

    }

}
