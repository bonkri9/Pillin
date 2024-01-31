package com.ssafy.yourpilling.pill_heeju.model.dao.impl;

import com.ssafy.yourpilling.pill_heeju.model.dao.PillDao;
import com.ssafy.yourpilling.pill_heeju.model.dao.entity.HNutrition;
import com.ssafy.yourpilling.pill_heeju.model.dao.entity.HOwnPill;
import com.ssafy.yourpilling.pill_heeju.model.dao.entity.HPill;
import com.ssafy.yourpilling.pill_heeju.model.dao.entity.HPillMember;
import com.ssafy.yourpilling.pill_heeju.model.dao.jpa.HPillJpaRepository;
import com.ssafy.yourpilling.pill_heeju.model.dao.jpa.HPillMemberJpaRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Repository;
import java.util.List;

import java.util.Optional;

@Repository
@AllArgsConstructor
public class HPillDaoImpl implements PillDao {

    private final HPillJpaRepository pillJpaRepository;
    private final HPillMemberJpaRepository pillMemberJpaRepository;

    @Override
    public boolean alreadyHavePill(Long memberId, Long pillId) {
        HPillMember hPillMember = findByMemberId(memberId);

        return hPillMember.getOwnPills()
                .stream()
                .filter(e -> e.getPill().getPillId().equals(pillId))
                .findAny()
                .isEmpty();
    }

    @Override
    public HPill pillDetail(HPill pillDetail) {
        return pillJpaRepository.findByPillId(pillDetail.getPillId())
                .orElseThrow(() -> new IllegalArgumentException("해당 영양제의 정보가 존재하지 않습니다."));
    }

    @Override
    public List<HPill> pillSearchList(HPill pillDetail) {
        List<HPill> pills = pillJpaRepository.findByNameAndManufacturer(pillDetail.getName());

        return Optional.of(pills)
                .filter(pillList -> !pillList.isEmpty())
                .orElseThrow(() -> new IllegalArgumentException("해당하는 영양제가 존재하지 않습니다."));
    }

    @Override
    public List<HPill> pillSearchListByNutrition(HNutrition nutritionDetail) {
        List<HPill> pills = pillJpaRepository.findByNutritionName(nutritionDetail.getNutrition());

        return Optional.of(pills)
                .filter(pillList -> !pillList.isEmpty())
                .orElseThrow(() -> new IllegalArgumentException("해당 성분을 가진 영양제가 존재하지 않습니다."));
    }

    @Override
    public List<HPill> pillSearchListByHealthConcern(Long categories) {
        List<HPill> pills = pillJpaRepository.findByCategories(categories);

        return Optional.of(pills)
                .filter(pillList -> !pillList.isEmpty())
                .orElseThrow(() -> new IllegalArgumentException("해당 건강고민을 가진 영양제가 존재하지 않습니다."));
    }

    private HPillMember findByMemberId(Long memberId) {
        return pillMemberJpaRepository.findByMemberId(memberId).
                orElseThrow(() -> new IllegalArgumentException("사용자를 찾을 수 없습니다."));
    }
}
