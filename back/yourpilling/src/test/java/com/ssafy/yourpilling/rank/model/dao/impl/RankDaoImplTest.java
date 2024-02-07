package com.ssafy.yourpilling.rank.model.dao.impl;

import com.ssafy.yourpilling.common.Gender;
import com.ssafy.yourpilling.rank.model.dao.entity.*;
import com.ssafy.yourpilling.rank.model.dao.jpa.RankBigCategoryRepository;
import com.ssafy.yourpilling.rank.model.dao.jpa.RankMidCategoryRepository;
import com.ssafy.yourpilling.rank.model.dao.jpa.RankPillMemberRepository;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@SpringBootTest
@Transactional
@ActiveProfiles("dev")
class RankDaoImplTest {

    @Autowired
    private RankPillMemberRepository rankPillMemberRepository;

    @Autowired
    private RankBigCategoryRepository rankBigCategoryRepository;

    @Autowired
    private RankMidCategoryRepository rankMidCategoryRepository;

    @Test
    @DisplayName("모든 사용자들이 보유중인 영양제 정보")
    public void rankCal(){
        // given, when
        List<EachCountPerPill> eachCountPerPills =
                rankPillMemberRepository.countPillTotalMemberWithAgeAndGender(20, 30, Gender.MAN.getGender());

        // then
        System.out.println("[total size] : " + eachCountPerPills.size());
        for (EachCountPerPill each : eachCountPerPills) {
            System.out.println("pillId : " + each.getPillId());
            System.out.println("size : " + each.getPillCount());
        }
    }

    @Test
    @DisplayName("모든 카테고리 조회")
    public void allCategories(){
        for (AllCategories categoryData : rankMidCategoryRepository.allCategories()) {
            System.out.println(categoryData.getBigCategoryId());
            System.out.println(categoryData.getBigCategoryNm());
            System.out.println(categoryData.getMidCategoryId());
            System.out.println(categoryData.getMidCategoryNm());
        }
    }

    private void registerData() {
        // 대분류
        RankBigCategory age = registerBigCategory("@성별 및 나이");
        RankBigCategory nu = registerBigCategory("@성분");
        RankBigCategory he = registerBigCategory("@건강고민");

        // 중분류
        registerMidCategory("@10대 이전,MAN", age);
        registerMidCategory("@20대,MAN", age);
        registerMidCategory("@30대,WOMAN", age);
        registerMidCategory("@루테인", nu);
        registerMidCategory("@비타민B", nu);
        registerMidCategory("@비타민B12", nu);
        registerMidCategory("@눈건강", he);
        registerMidCategory("@간겅강", he);
        registerMidCategory("@여성 건강", he);
    }

    private RankMidCategory registerMidCategory(String name, RankBigCategory bigCategory){
        RankMidCategory mid = RankMidCategory
                .builder()
                .categoryNm(name)
                .bigCategory(bigCategory)
                .build();

        rankMidCategoryRepository.save(mid);
        return mid;
    }

    private RankBigCategory registerBigCategory(String name){
        RankBigCategory big = RankBigCategory
                .builder()
                .categoryNm(name)
                .build();

        rankBigCategoryRepository.save(big);
        return big;
    }
}