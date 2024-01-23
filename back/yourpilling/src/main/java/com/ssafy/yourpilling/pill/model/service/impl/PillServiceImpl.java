package com.ssafy.yourpilling.pill.model.service.impl;

import com.ssafy.yourpilling.pill.model.dao.PillDao;
import com.ssafy.yourpilling.pill.model.service.PillService;
import com.ssafy.yourpilling.pill.model.service.mapper.PillServiceMapper;
import com.ssafy.yourpilling.pill.model.service.mapper.value.OwnPillRegisterValue;
import com.ssafy.yourpilling.pill.model.service.vo.PillRegisterVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import static java.time.LocalDateTime.now;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class PillServiceImpl implements PillService {

    private final PillDao pillDao;
    private final PillServiceMapper mapper;

    @Transactional
    @Override
    public void register(PillRegisterVo vo) {
        System.out.println("----");
        OwnPillRegisterValue value = OwnPillRegisterValue
                .builder()
                .vo(vo)
                .member(pillDao.findByMemberId(vo.getMemberId()))
                .pill(pillDao.findByPillId(vo.getPillId()))
                .isAlarm(false)
                .createAt(now())
                .build();

        pillDao.register(mapper.mapToOwnPill(value));

        System.out.println("-------");
    }
}
