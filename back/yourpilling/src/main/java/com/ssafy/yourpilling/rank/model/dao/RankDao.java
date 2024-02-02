package com.ssafy.yourpilling.rank.model.dao;

import com.ssafy.yourpilling.rank.model.dao.entity.*;

import java.util.List;

public interface RankDao {

    void registerAll(List<Rank> rank);

    List<EachCountPerPill> rankAgeAndGender(int startAgeGroup, int endAgeGroup, String gender);

    List<EachCountPerPill> rankNutrition(String nutrient);

    RankMidCategory searchMidCategoryByMidCategoryName(String midCategoryName);

    RankPill searchPillByPillId(Long pillId);

    List<AllCategories> allCategories();
}
