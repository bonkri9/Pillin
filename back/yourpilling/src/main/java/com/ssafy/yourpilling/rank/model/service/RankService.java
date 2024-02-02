package com.ssafy.yourpilling.rank.model.service;

import com.ssafy.yourpilling.rank.model.service.vo.wrap.CategoryCategoryVos;

public interface RankService {

    void generateWeeklyRank();

    CategoryCategoryVos categories();
}
