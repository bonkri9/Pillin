package com.ssafy.yourpilling.pill_heeju.model.dao;

import com.ssafy.yourpilling.pill_heeju.model.dao.entity.PillDetail;

import java.util.Optional;

public interface PillDao {

    Optional<PillDetail> pillDetail(PillDetail pillDetail);
}
