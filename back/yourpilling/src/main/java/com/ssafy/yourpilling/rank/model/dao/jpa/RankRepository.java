package com.ssafy.yourpilling.rank.model.dao.jpa;

import com.ssafy.yourpilling.rank.model.dao.entity.Rank;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface RankRepository extends JpaRepository<Rank, Long> {

    @Query("SELECT r " +
            "FROM Rank r " +
            "JOIN r.midCategory m " +
            "WHERE r.weeks = :weeks AND m.categoryNm NOT LIKE '%대%' ")
    List<Rank> allRankExceptStringAgeGroupAndGenderCategoryName(@Param("weeks") Integer weeks);

    List<Rank> findByWeeks(Integer weeks);

}
