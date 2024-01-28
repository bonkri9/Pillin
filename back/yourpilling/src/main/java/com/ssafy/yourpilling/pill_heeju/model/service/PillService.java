package com.ssafy.yourpilling.pill_heeju.model.service;


import com.ssafy.yourpilling.pill_heeju.model.dao.entity.PillDetail;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.NutritionVo;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.PillDetailVo;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.response.ResponsePillSearchListVo.ResponsePillSearchListData;

import java.util.List;

public interface PillService {
    //영양제 상세 조회
    PillDetail pillDetail(PillDetailVo vo);

    ResponsePillSearchListData pillSearchList(PillDetailVo vo);

    ResponsePillSearchListData pillSearchList(NutritionVo vo);
}
