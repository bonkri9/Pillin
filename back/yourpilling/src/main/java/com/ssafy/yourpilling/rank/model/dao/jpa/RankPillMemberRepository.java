package com.ssafy.yourpilling.rank.model.dao.jpa;

import com.ssafy.yourpilling.rank.model.dao.entity.EachCountPerPill;
import com.ssafy.yourpilling.rank.model.dao.entity.RankPillMember;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface RankPillMemberRepository extends JpaRepository<RankPillMember, Long> {

    @Query(value = "SELECT op.pill_pill_id AS pillId, COUNT(op.pill_pill_id) AS pillCount " +
            "FROM (SELECT m.member_id FROM RankPillMember m " +
            "       WHERE YEAR(CURRENT_DATE) - YEAR(m.birth) BETWEEN :startAge AND :endAge AND m.gender = :gender) AS m " +
            "JOIN ownpill op ON m.member_id = op.member_id " +
            "GROUP BY op.pill_pill_id " +
            "DESC COUNT(op.pill_pill_id)", nativeQuery = true)
    List<EachCountPerPill> countPillTotalMember(int startAge, int endAge, String gender);
}
