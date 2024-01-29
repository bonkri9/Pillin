package com.ssafy.yourpilling.pill_heeju.model.service;


import com.ssafy.yourpilling.pill_heeju.model.dao.entity.HPill;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.MidCategoryVo;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.NutritionVo;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.HPillVo;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.out.ResponsePillSearchListVo.ResponsePillSearchListData;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.out.ResponsePillVo;

public interface PillService {
    //영양제 상세 조회
    ResponsePillVo pillDetail(HPillVo vo);

    ResponsePillSearchListData pillSearchList(HPillVo vo);

    ResponsePillSearchListData pillSearchList(NutritionVo vo);

    ResponsePillSearchListData pillSearchList(MidCategoryVo vo);
}
