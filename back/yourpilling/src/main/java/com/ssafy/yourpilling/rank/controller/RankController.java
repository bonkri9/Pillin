package com.ssafy.yourpilling.rank.controller;

import com.ssafy.yourpilling.rank.controller.mapper.RankControllerMapper;
import com.ssafy.yourpilling.rank.model.service.RankService;
import com.ssafy.yourpilling.rank.model.service.vo.out.wrap.OutCategoryVos;
import com.ssafy.yourpilling.rank.model.service.vo.out.wrap.OutRankVos;
import com.ssafy.yourpilling.security.auth.PrincipalDetails;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
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
    ResponseEntity<OutCategoryVos> categories(){
        return ResponseEntity.ok(rankService.categories());
    }

    @GetMapping("/rankTest")
    ResponseEntity<Void> rankTest(){
         rankService.generateWeeklyRank();
         return ResponseEntity.ok(null);
    }

    @GetMapping
    ResponseEntity<OutRankVos> rank(@AuthenticationPrincipal PrincipalDetails principalDetails){
        OutRankVos vos = rankService.rank(mapper.mapToRankVo(principalDetails.getMember().getMemberId()));
        return ResponseEntity.ok(vos);
    }
}
