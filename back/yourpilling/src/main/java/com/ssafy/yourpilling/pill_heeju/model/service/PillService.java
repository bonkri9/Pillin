package com.ssafy.yourpilling.pill_heeju.model.service;


import com.ssafy.yourpilling.pill_heeju.model.dao.entity.PillDetail;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.PillDetailVo;

public interface PillService {
    //영양제 상세 조회
    PillDetail pillDetail(PillDetailVo vo);
}
