package com.ssafy.yourpilling.pill_heeju.model.service;


import com.ssafy.yourpilling.pill_heeju.model.dao.entity.PillDetail;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.PillDetailVo;

import java.util.Optional;

public interface PillService {
    //영양제 상세 조회
    Optional<PillDetail> pillDetail(PillDetailVo vo);
}
