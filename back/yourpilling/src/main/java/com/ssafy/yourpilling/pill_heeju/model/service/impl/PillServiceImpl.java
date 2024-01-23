package com.ssafy.yourpilling.pill_heeju.model.service.impl;

import com.ssafy.yourpilling.pill_heeju.model.dao.PillDao;
import com.ssafy.yourpilling.pill_heeju.model.dao.entity.PillDetail;
import com.ssafy.yourpilling.pill_heeju.model.service.PillService;
import com.ssafy.yourpilling.pill_heeju.model.service.mapper.PillServiceMapper;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.PillDetailVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class PillServiceImpl implements PillService {

    private final PillDao pillDao;
    private final PillServiceMapper mapper;


    @Override
    public Optional<PillDetail> pillDetail(PillDetailVo vo) {
        return pillDao.pillDetail(mapper.mapToPillId(vo));
    }
}
