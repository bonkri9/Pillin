package com.ssafy.yourpilling.rank.model.service;

import com.ssafy.yourpilling.rank.model.service.vo.in.RankVo;
import com.ssafy.yourpilling.rank.model.service.vo.out.wrap.OutCategoryVos;
import com.ssafy.yourpilling.rank.model.service.vo.out.wrap.OutRankVos;

public interface RankService {

    void generateWeeklyRank();

    OutCategoryVos categories();

    OutRankVos rank(RankVo vo);
}
