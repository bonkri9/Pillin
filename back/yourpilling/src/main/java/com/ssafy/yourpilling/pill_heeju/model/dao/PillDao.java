package com.ssafy.yourpilling.pill_heeju.model.dao;

import com.ssafy.yourpilling.pill_heeju.model.dao.entity.HPill;
import com.ssafy.yourpilling.pill_heeju.model.dao.entity.HNutrition;

import java.util.List;

public interface PillDao {

    boolean alreadyHavePill(Long memberId, Long pillId);

    HPill pillDetail(HPill pillDetail);
    List<HPill> pillSearchList(HPill pillDetail);
    List<HPill> pillSearchListByNutrition(HNutrition nutritionDetail);

    List<HPill> pillSearchListByHealthConcern(Long categories);
}
