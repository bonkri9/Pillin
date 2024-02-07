package com.ssafy.yourpilling.rank.model.service.mapper;

import com.ssafy.yourpilling.rank.model.dao.entity.*;
import com.ssafy.yourpilling.rank.model.service.vo.out.OutBigCategoryVo;
import com.ssafy.yourpilling.rank.model.service.vo.out.OutBigCategoryVo.OutMidCategoryVo;
import com.ssafy.yourpilling.rank.model.service.vo.out.OutRankVo;
import com.ssafy.yourpilling.rank.model.service.vo.out.OutRankVo.OutRankData;
import com.ssafy.yourpilling.rank.model.service.vo.out.wrap.OutCategoryVos;
import com.ssafy.yourpilling.rank.model.service.vo.out.wrap.OutRankVos;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Component
public class RankServiceMapper {

    public Rank mapToRank(int weeks, int year, int rank, RankPill pill,
                          RankMidCategory mid, LocalDateTime createAt){
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

    public OutCategoryVos mapToCategoryCategoryVos(List<AllCategories> allCategories) {
        Map<Long, List<AllCategories>> partition = partitionByBigCategoryId(allCategories);

        List<OutBigCategoryVo> vos = new ArrayList<>();

        for (Long key : partition.keySet()) {
            if(partition.get(key).isEmpty()) continue;

            vos.add(mapToCategoryBigCategoryVo(key, partition, getMidCategies(key, partition)));
        }

        return OutCategoryVos
                .builder()
                .categoires(vos)
                .build();
    }

    private static Map<Long, List<AllCategories>> partitionByBigCategoryId(List<AllCategories> allCategories) {
        return allCategories.stream()
                .collect(Collectors.groupingBy(AllCategories::getBigCategoryId));
    }

    private static List<OutMidCategoryVo> getMidCategies(Long key, Map<Long, List<AllCategories>> partition) {
        List<OutMidCategoryVo> mids = new ArrayList<>();
        for (AllCategories info : partition.get(key)) {
            mids.add(mapToCategoryMidCategory(info));
        }
        return mids;
    }

    private static OutBigCategoryVo mapToCategoryBigCategoryVo(Long key, Map<Long, List<AllCategories>> partition, List<OutMidCategoryVo> mids) {
        return OutBigCategoryVo
                .builder()
                .bigCategoryId(partition.get(key).get(0).getBigCategoryId())
                .bigCategoryName(partition.get(key).get(0).getBigCategoryNm())
                .midCategories(mids)
                .build();
    }

    private static OutMidCategoryVo mapToCategoryMidCategory(AllCategories info) {
        return OutMidCategoryVo
                .builder()
                .midCategoryId(info.getMidCategoryId())
                .midCategoryName(info.getMidCategoryNm())
                .build();
    }

    public OutRankVos mapToOutRankVos(List<OutRankVo> vos){
        return OutRankVos
                .builder()
                .data(vos)
                .build();
    }

    public OutRankVo mapToOutRankVo(RankMidCategory midCategory, List<Rank> rank){
        return OutRankVo
                .builder()
                .midCategoryId(midCategory.getMidCategoryId())
                .midCategoryName(midCategory.getCategoryNm())
                .outRankData(mapToOutRankDatas(rank))
                .build();
    }

    public List<OutRankData> mapToOutRankDatas(List<Rank> ranks){
        return ranks.stream()
                .map(r -> mapToOutRankData(r.getPill(), r.getRank()))
                .toList();

    }

    private OutRankData mapToOutRankData(RankPill pill, Integer rank){
        return OutRankData
                .builder()
                .pillId(pill.getPillId())
                .pillName(pill.getName())
                .rank(rank)
                .manufacturer(pill.getManufacturer())
                .imageUrl(pill.getImageUrl())
                .build();
    }
}
