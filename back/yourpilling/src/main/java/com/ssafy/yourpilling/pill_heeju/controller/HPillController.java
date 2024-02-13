package com.ssafy.yourpilling.pill_heeju.controller;

import com.ssafy.yourpilling.pill_heeju.controller.dto.request.RequestHealthConcernsCategoryDto;
import com.ssafy.yourpilling.pill_heeju.controller.mapper.HPillControllerMapper;
import com.ssafy.yourpilling.pill_heeju.model.dao.entity.HPill;
import com.ssafy.yourpilling.pill_heeju.model.service.PillService;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.out.ResponsePillSearchListVo.ResponsePillSearchListData;
import com.ssafy.yourpilling.pill_heeju.model.service.vo.out.ResponsePillVo;
import com.ssafy.yourpilling.security.auth.PrincipalDetails;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/v1/pill")
public class HPillController {

    private final PillService pillService;
    private final HPillControllerMapper mapper;
    @GetMapping("/detail")
    ResponseEntity<ResponsePillVo> pillDetail(@AuthenticationPrincipal PrincipalDetails principalDetails,
                                              @RequestParam(value = "pillId") Long pillId){
        // 영양제 아이디를 받으면 영양제에 대한 영양제상세정보(영양소 정보 포함) 반환
        log.info("[요청 : 영양제 상세 정보] member_id : {}, pill_id : {}", principalDetails.getMember().getMemberId(), pillId);
        ResponsePillVo pill =
                pillService.pillDetail(mapper.mapToPillIdVo(principalDetails.getMember().getMemberId(), pillId));

        return ResponseEntity.ok(pill);
    }

    @GetMapping("/search")
    ResponseEntity<ResponsePillSearchListData> pillSearch(@RequestParam(value = "pillName") String pillName){
        // 영양제 이름(제품명, 제조사)을 받으면 영양제에 대한 영양제 리스트 반환
        log.info("[요청 : 제품명 기반 검색] pill_name : {}", pillName);
        ResponsePillSearchListData data = pillService.pillSearchList(mapper.mapToPillNameVo(pillName));

        return ResponseEntity.ok(data);
    }
    @GetMapping("/search/nutrition")
    ResponseEntity<ResponsePillSearchListData> pillSearchByNutritionName(@RequestParam(value = "nutritionName") String nutritionName){
        // 영양제 성분을 받으면 영양제에 대한 영양제 리스트 반환
        log.info("[요청 : 성분 기반 검색] nutrition_name : {}", nutritionName);
        ResponsePillSearchListData data = pillService.pillSearchList(mapper.mapToNutritionIdVo(nutritionName));

        return ResponseEntity.ok(data);
    }
    @GetMapping("/search/category")
    ResponseEntity<ResponsePillSearchListData> pillSearchByCategory(@RequestParam(value = "healthConcerns") Long healthConcerns){
        // 영양제 건강고민을 받으면 영양제에 대한 영양제 리스트 반환
        log.info("[요청 : 건강고민 기반 검색] health_concern_id : {}", healthConcerns);
        ResponsePillSearchListData data = pillService.pillSearchList(mapper.mapToCategoryVo(healthConcerns));

        return ResponseEntity.ok(data);
    }
}
