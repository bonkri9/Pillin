package com.ssafy.yourpilling.rank.controller.mapper;

import com.ssafy.yourpilling.rank.model.service.vo.in.RankVo;
import org.springframework.stereotype.Component;

@Component
public class RankControllerMapper {

    public RankVo mapToRankVo(Long memberId){
        return RankVo
                .builder()
                .memberId(memberId)
                .build();
    }
}
