package com.ssafy.yourpilling.pill_heeju.controller.mapper;

import com.ssafy.yourpilling.pill_heeju.model.service.vo.PillDetailVo;
import org.springframework.stereotype.Component;

@Component
public class HPillControllerMapper {
    public PillDetailVo mapToPillIdVo(Long pillId){
        return PillDetailVo.builder().pillId(pillId).build();
    }
    public PillDetailVo mapToPillNameVo(String pillName) {
        return PillDetailVo.builder().pillName(pillName).build();
    }
}
