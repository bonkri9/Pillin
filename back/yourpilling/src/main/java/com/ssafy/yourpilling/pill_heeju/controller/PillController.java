package com.ssafy.yourpilling.pill_heeju.controller;

import com.ssafy.yourpilling.pill_heeju.controller.dto.request.RequestPillDetailDto;
import com.ssafy.yourpilling.pill_heeju.controller.mapper.PillControllerMapper;
import com.ssafy.yourpilling.pill_heeju.model.dao.entity.PillDetail;
import com.ssafy.yourpilling.pill_heeju.model.service.PillService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/pill")
public class PillController {

    private final PillService pillService;
    private final PillControllerMapper mapper;
    @GetMapping("/detail")
    ResponseEntity<Void> pillDetail(@RequestBody RequestPillDetailDto requestPillDetailDto){
        // 영양제 아이디를 받으면 영양제에 대한 영양제상세정보(영양소 정보 포함) 반환
        Optional<PillDetail> pd = pillService.pillDetail(mapper.mapToPillIdVo(requestPillDetailDto));

        System.out.println(pd);

        return ResponseEntity.ok().build();
    }
}
