package com.ssafy.yourpilling.rank.model.service.mapper;

import com.ssafy.yourpilling.rank.model.dao.entity.Rank;
import com.ssafy.yourpilling.rank.model.dao.entity.RankMidCategory;
import com.ssafy.yourpilling.rank.model.dao.entity.RankPill;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

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
}
