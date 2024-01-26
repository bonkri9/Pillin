package com.ssafy.yourpilling.pill_heeju.model.service.mapper;

import com.ssafy.yourpilling.pill_heeju.model.dao.entity.PillDetail;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.PillDetailVo;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.response.ResponsePillSearchDataVo;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class HPillServiceMapper {

    public PillDetail mapToPillId(PillDetailVo vo){
        return PillDetail.builder().pillId(vo.getPillId()).build();
    }

    public PillDetail mapToPillName(PillDetailVo vo) {
        return PillDetail.builder().name(vo.getPillName()).build();
    }

    public List<ResponsePillSearchDataVo> mapToResponsePillSearchListDate(List<PillDetail> pillDetailList){

        List<ResponsePillSearchDataVo> items = new ArrayList<ResponsePillSearchDataVo>();

        for (PillDetail pillDetail : pillDetailList) {
            items.add(mapToResponsePillSearchListItem(pillDetail));
        }

        return items;
    }
    private ResponsePillSearchDataVo mapToResponsePillSearchListItem(PillDetail pillDetail){
        return ResponsePillSearchDataVo
                .builder()
                .pillId(pillDetail.getPillId())
                .pillName(pillDetail.getName())
                .manufacturer(pillDetail.getManufacturer())
                .imageUrl(pillDetail.getImageUrl())
                .build();
    }
}
