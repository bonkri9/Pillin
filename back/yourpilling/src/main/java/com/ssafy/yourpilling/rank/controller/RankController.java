package com.ssafy.yourpilling.rank.controller;

import com.ssafy.yourpilling.rank.controller.mapper.RankControllerMapper;
import com.ssafy.yourpilling.rank.model.service.RankService;
import com.ssafy.yourpilling.rank.model.service.vo.wrap.CategoryCategoryVos;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/rank")
public class RankController {

    private final RankControllerMapper mapper;

    private final RankService rankService;

    @GetMapping("/categories")
    ResponseEntity<CategoryCategoryVos> categories(){
        return ResponseEntity.ok(rankService.categories());
    }
}
