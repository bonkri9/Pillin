package com.ssafy.yourpilling.rank.model.service.mapper;

import com.ssafy.yourpilling.rank.model.dao.entity.AllCategories;
import com.ssafy.yourpilling.rank.model.dao.entity.Rank;
import com.ssafy.yourpilling.rank.model.dao.entity.RankMidCategory;
import com.ssafy.yourpilling.rank.model.dao.entity.RankPill;
import com.ssafy.yourpilling.rank.model.service.vo.CategoryBigCategoryVo;
import com.ssafy.yourpilling.rank.model.service.vo.CategoryBigCategoryVo.CategoryMidCategoryVo;
import com.ssafy.yourpilling.rank.model.service.vo.wrap.CategoryCategoryVos;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Component
public class RankServiceMapper {

    public Rank mapToRank(int weeks, int year, int rank, RankPill pill, RankMidCategory mid, LocalDateTime createAt){
        return Rank
                .builder()
                .weeks(weeks)
                .year(year)
                .rank(rank)
                .pill(pill)
                .midCategory(mid)
                .createAt(createAt)
                .build();
    }

    public CategoryCategoryVos mapToCategoryCategoryVos(List<AllCategories> allCategories) {
        Map<Long, List<AllCategories>> partition = partitionByBigCategoryId(allCategories);

        List<CategoryBigCategoryVo> vos = new ArrayList<>();

        for (Long key : partition.keySet()) {
            if(partition.get(key).isEmpty()) continue;

            vos.add(mapToCategoryBigCategoryVo(key, partition, getMidCategies(key, partition)));
        }

        return CategoryCategoryVos
                .builder()
                .categoires(vos)
                .build();
    }

    private static Map<Long, List<AllCategories>> partitionByBigCategoryId(List<AllCategories> allCategories) {
        return allCategories.stream()
                .collect(Collectors.groupingBy(AllCategories::getBigCategoryId));
    }

    private static List<CategoryMidCategoryVo> getMidCategies(Long key, Map<Long, List<AllCategories>> partition) {
        List<CategoryMidCategoryVo> mids = new ArrayList<>();
        for (AllCategories info : partition.get(key)) {
            mids.add(mapToCategoryMidCategory(info));
        }
        return mids;
    }

    private static CategoryBigCategoryVo mapToCategoryBigCategoryVo(Long key, Map<Long, List<AllCategories>> partition, List<CategoryMidCategoryVo> mids) {
        return CategoryBigCategoryVo
                .builder()
                .bigCategoryId(partition.get(key).get(0).getBigCategoryId())
                .bigCategoryName(partition.get(key).get(0).getBigCategoryNm())
                .midCategories(mids)
                .build();
    }

    private static CategoryMidCategoryVo mapToCategoryMidCategory(AllCategories info) {
        return CategoryMidCategoryVo
                .builder()
                .midCategoryId(info.getMidCategoryId())
                .midCategoryName(info.getMidCategoryNm())
                .build();
    }
}
