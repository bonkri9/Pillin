package com.ssafy.yourpilling.rank.model.dao.impl;

import com.ssafy.yourpilling.rank.model.dao.RankDao;
import com.ssafy.yourpilling.rank.model.dao.entity.EachCountPerPill;
import com.ssafy.yourpilling.rank.model.dao.entity.Rank;
import com.ssafy.yourpilling.rank.model.dao.entity.RankMidCategory;
import com.ssafy.yourpilling.rank.model.dao.entity.RankPill;
import com.ssafy.yourpilling.rank.model.dao.jpa.RankMidCategoryRepository;
import com.ssafy.yourpilling.rank.model.dao.jpa.RankPillMemberRepository;
import com.ssafy.yourpilling.rank.model.dao.jpa.RankPillRepository;
import com.ssafy.yourpilling.rank.model.dao.jpa.RankRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class RankDaoImpl implements RankDao {

    private final RankRepository rankRepository;
    private final RankPillRepository rankPillRepository;
    private final RankPillMemberRepository rankPillMemberRepository;
    private final RankMidCategoryRepository rankMidCategoryRepository;

    @Override
    public void registerAll(List<Rank> rank) {
        rankRepository.saveAll(rank);
    }

    @Override
    public RankMidCategory searchMidCategoryByMidCategoryName(String midCategoryName) {
        return rankMidCategoryRepository.findByCategoryNm(midCategoryName)
                .orElseThrow(() -> new IllegalArgumentException("알맞은 중분류를 찾을 수 없습니다."));
    }

    @Override
    public RankPill searchPillByPillId(Long pillId) {
        return rankPillRepository.findByPillId(pillId)
                .orElseThrow(() -> new IllegalArgumentException("알맞은 영양제를 찾을 수 없습니다."));
    }

    @Override
    public List<EachCountPerPill> rankAgeAndGender(int startAgeGroup, int endAgeGroup, String gender) {
        return rankPillMemberRepository.countPillTotalMemberWithAgeAndGender(startAgeGroup, endAgeGroup, gender);
    }

    @Override
    public List<EachCountPerPill> rankNutrition(String nutrient) {
        return rankPillMemberRepository.countPillTotalMemberWithNutrient(nutrient);
    }
}
