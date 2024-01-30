package com.ssafy.yourpilling.rank.controller;

import com.ssafy.yourpilling.rank.controller.mapper.RankControllerMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/rank")
public class RankController {

    private final RankControllerMapper mapper;
}
