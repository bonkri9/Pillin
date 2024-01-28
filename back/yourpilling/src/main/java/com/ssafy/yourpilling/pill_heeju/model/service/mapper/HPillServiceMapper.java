package com.ssafy.yourpilling.pill_heeju.model.service.mapper;

import com.ssafy.yourpilling.pill_heeju.model.dao.entity.NutritionDetail;
import com.ssafy.yourpilling.pill_heeju.model.dao.entity.PillDetail;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.NutritionVo;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.PillDetailVo;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.response.ResponsePillSearchListVo;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.response.ResponsePillSearchListVo.ResponsePillSearchItem;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.response.ResponsePillSearchListVo.ResponsePillSearchListData;
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

    public NutritionDetail mapToNutritionName(NutritionVo vo) {
        return NutritionDetail.builder().nutrition(vo.getNutrition()).build();
    }

    public ResponsePillSearchListData mapToResponsePillSearchListData(List<PillDetail> pillDetailList){

        List<ResponsePillSearchItem> items = new ArrayList<>();

        for (PillDetail pillDetail : pillDetailList) {
            items.add(mapToResponsePillSearchItem(pillDetail));
        }

        return ResponsePillSearchListData.builder().data(items).build();
    }
    private ResponsePillSearchItem mapToResponsePillSearchItem(PillDetail pillDetail){
        return ResponsePillSearchItem
                .builder()
                .pillId(pillDetail.getPillId())
                .pillName(pillDetail.getName())
                .manufacturer(pillDetail.getManufacturer())
                .imageUrl(pillDetail.getImageUrl())
                .build();
    }
}
