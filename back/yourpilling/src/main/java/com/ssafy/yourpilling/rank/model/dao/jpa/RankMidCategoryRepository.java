package com.ssafy.yourpilling.rank.model.dao.jpa;

import com.ssafy.yourpilling.rank.model.dao.entity.AllCategories;
import com.ssafy.yourpilling.rank.model.dao.entity.RankMidCategory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface RankMidCategoryRepository extends JpaRepository<RankMidCategory, Long> {

    Optional<RankMidCategory> findByCategoryNm(@Param("name") String name);

    @Query(value =
            "SELECT m.mid_category_id AS midCategoryId, " +
                    "m.category_nm AS midCategoryNm, " +
                    "b.big_category_id AS bigCategoryId, " +
                    "b.category_nm AS bigCategoryNm " +
                    "FROM midcategory m " +
                    "JOIN bigcategory b ON m.big_category_id = b.big_category_id",
            nativeQuery = true)
    List<AllCategories> allCategories();
}
