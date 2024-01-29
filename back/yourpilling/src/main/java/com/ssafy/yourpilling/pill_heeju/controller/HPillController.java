package com.ssafy.yourpilling.pill_heeju.controller;

import com.ssafy.yourpilling.pill_heeju.controller.dto.request.RequestHealthConcernsCategoryDto;
import com.ssafy.yourpilling.pill_heeju.controller.mapper.HPillControllerMapper;
import com.ssafy.yourpilling.pill_heeju.model.dao.entity.HPill;
import com.ssafy.yourpilling.pill_heeju.model.service.PillService;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.out.ResponsePillSearchListVo.ResponsePillSearchListData;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.out.ResponsePillVo;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/pill")
public class HPillController {

    private final PillService pillService;
    private final HPillControllerMapper mapper;
    @GetMapping("/detail")
    ResponseEntity<ResponsePillVo> pillDetail(@RequestParam(value = "pillId") Long pillId){
        // 영양제 아이디를 받으면 영양제에 대한 영양제상세정보(영양소 정보 포함) 반환
        ResponsePillVo pill = pillService.pillDetail(mapper.mapToPillIdVo(pillId));

        return ResponseEntity.ok(pill);
    }

    @GetMapping("/search")
    ResponseEntity<ResponsePillSearchListData> pillSearch(@RequestParam(value = "pillName") String pillName){
        // 영양제 이름(제품명)을 받으면 영양제에 대한 영양제 리스트 반환
        ResponsePillSearchListData data = pillService.pillSearchList(mapper.mapToPillNameVo(pillName));

        return ResponseEntity.ok(data);
    }
    @GetMapping("/search/nutrition")
    ResponseEntity<ResponsePillSearchListData> pillSearchByNutritionName(@RequestParam(value = "nutritionName") String nutritionName){
        // 영양제 이름(제품명)을 받으면 영양제에 대한 영양제 리스트 반환
        ResponsePillSearchListData data = pillService.pillSearchList(mapper.mapToNutritionIdVo(nutritionName));

        return ResponseEntity.ok(data);
    }
    @PostMapping("/search/category")
    ResponseEntity<ResponsePillSearchListData> pillSearchByCategory(@RequestBody RequestHealthConcernsCategoryDto dto){
        // 영양제 이름(제품명)을 받으면 영양제에 대한 영양제 리스트 반환
        ResponsePillSearchListData data = pillService.pillSearchList(mapper.mapToCategoryVo(dto.getHealthConcerns()));

        return ResponseEntity.ok(data);
    }
}
