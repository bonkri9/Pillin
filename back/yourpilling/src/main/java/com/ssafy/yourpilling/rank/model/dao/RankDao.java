package com.ssafy.yourpilling.rank.model.dao;

import com.ssafy.yourpilling.rank.model.dao.entity.EachCountPerPill;
import com.ssafy.yourpilling.rank.model.dao.entity.Rank;
import com.ssafy.yourpilling.rank.model.dao.entity.RankMidCategory;
import com.ssafy.yourpilling.rank.model.dao.entity.RankPill;

import java.util.List;

public interface RankDao {

    void registerAll(List<Rank> rank);

    List<EachCountPerPill> rankPillMemberRepository(int startAgeGroup, int endAgeGroup, String gender);

    RankMidCategory searchMidCategoryByMidCategoryName(String midCategoryName);

    RankPill searchPillByPillId(Long pillId);
}
