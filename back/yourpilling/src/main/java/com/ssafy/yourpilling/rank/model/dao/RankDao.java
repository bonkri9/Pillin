package com.ssafy.yourpilling.rank.model.dao;

import com.ssafy.yourpilling.rank.model.dao.entity.EachCountPerPill;
import com.ssafy.yourpilling.rank.model.dao.entity.Rank;
import com.ssafy.yourpilling.rank.model.dao.entity.RankMidCategory;
import com.ssafy.yourpilling.rank.model.dao.entity.RankPill;

import java.util.List;

public interface RankDao {

    void registerAll(List<Rank> rank);

    List<EachCountPerPill> rankAgeAndGender(int startAgeGroup, int endAgeGroup, String gender);

    List<EachCountPerPill> rankNutrition(String nutrient);

    RankMidCategory searchMidCategoryByMidCategoryName(String midCategoryName);

    RankPill searchPillByPillId(Long pillId);
}
