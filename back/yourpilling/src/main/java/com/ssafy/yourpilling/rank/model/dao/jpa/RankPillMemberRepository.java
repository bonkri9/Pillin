package com.ssafy.yourpilling.rank.model.dao.jpa;

import com.ssafy.yourpilling.rank.model.dao.entity.EachCountPerPill;
import com.ssafy.yourpilling.rank.model.dao.entity.RankPillMember;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface RankPillMemberRepository extends JpaRepository<RankPillMember, Long> {

    @Query(value =
            "SELECT p.pill_pill_id AS pillId, COUNT(p.pill_pill_id) AS pillCount " +
                    "FROM (SELECT m.member_id FROM members m " +
                    "       WHERE YEAR(CURRENT_DATE) - YEAR(m.birth) BETWEEN :startAge AND :endAge AND m.gender = :gender) AS m " +
                    "JOIN ownpill p ON m.member_id = p.member_id " +
                    "GROUP BY p.pill_pill_id " +
                    "ORDER BY COUNT(p.pill_pill_id) DESC", nativeQuery = true)
    List<EachCountPerPill> countPillTotalMemberWithAgeAndGender(int startAge, int endAge, String gender);

    @Query(value =
            "SELECT n.pill_id AS pillId, COUNT(n.pill_id) AS pillCount " +
            "FROM members m " +
            "JOIN ownpill o ON m.member_id = o.member_id " +
            "JOIN pill p ON o.pill_pill_id = p.pill_id " +
            "JOIN nutrition n ON p.pill_id = n.pill_id " +
            "WHERE n.nutrition = :targetNutrient " +
            "GROUP BY n.pill_id", nativeQuery = true)
    List<EachCountPerPill> countPillTotalMemberWithNutrient(String targetNutrient);
}
