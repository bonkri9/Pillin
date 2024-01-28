package com.ssafy.yourpilling.pill_heeju.model.service.impl;

import com.ssafy.yourpilling.pill_heeju.model.dao.PillDao;
import com.ssafy.yourpilling.pill_heeju.model.dao.entity.PillDetail;
import com.ssafy.yourpilling.pill_heeju.model.service.PillService;
import com.ssafy.yourpilling.pill_heeju.model.service.mapper.HPillServiceMapper;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.MidCategoryVo;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.NutritionVo;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.PillDetailVo;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.response.ResponsePillSearchListVo.ResponsePillSearchListData;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class HPillServiceImpl implements PillService {

    private final PillDao pillDao;
    private final HPillServiceMapper mapper;


    @Override
    public PillDetail pillDetail(PillDetailVo vo) {
        return pillDao.pillDetail(mapper.mapToPillId(vo));
    }

    @Override
    public ResponsePillSearchListData pillSearchList(PillDetailVo vo) {

        return mapper.mapToResponsePillSearchListData(pillDao.pillSearchList(mapper.mapToPillName(vo)));
    }

    @Override
    public ResponsePillSearchListData pillSearchList(NutritionVo vo) {
        return mapper.mapToResponsePillSearchListData
                (pillDao.pillSearchListByNutrition(mapper.mapToNutritionName(vo)));
    }

    @Override
    public ResponsePillSearchListData pillSearchList(MidCategoryVo vo) {
        return mapper.mapToResponsePillSearchListData
                (pillDao.pillSearchListByHealthConcern(mapper.mapToMidCategories(vo)));
    }
}
