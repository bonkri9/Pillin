package com.ssafy.yourpilling.pill_heeju.model.service.mapper;

import com.ssafy.yourpilling.pill_heeju.model.dao.entity.PillDetail;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.PillDetailVo;
import org.springframework.stereotype.Component;

@Component
public class HPillServiceMapper {

    public PillDetail mapToPillId(PillDetailVo vo){
        return PillDetail.builder().pillId(vo.getPillId()).build();
    }

}
