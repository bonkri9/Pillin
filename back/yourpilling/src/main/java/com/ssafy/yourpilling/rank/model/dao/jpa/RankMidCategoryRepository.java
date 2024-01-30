package com.ssafy.yourpilling.rank.model.dao.jpa;

import com.ssafy.yourpilling.rank.model.dao.entity.RankMidCategory;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface RankMidCategoryRepository extends JpaRepository<RankMidCategory, Long> {
    Optional<RankMidCategory> findByCategoryNm(String name);
}
