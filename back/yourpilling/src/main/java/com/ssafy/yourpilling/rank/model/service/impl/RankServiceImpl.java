package com.ssafy.yourpilling.rank.model.service.impl;

import com.ssafy.yourpilling.common.AgeGroup;
import com.ssafy.yourpilling.common.Gender;
import com.ssafy.yourpilling.common.Nutrient;
import com.ssafy.yourpilling.rank.model.dao.RankDao;
import com.ssafy.yourpilling.rank.model.dao.entity.EachCountPerPill;
import com.ssafy.yourpilling.rank.model.dao.entity.Rank;
import com.ssafy.yourpilling.rank.model.dao.entity.RankMidCategory;
import com.ssafy.yourpilling.rank.model.dao.entity.RankPill;
import com.ssafy.yourpilling.rank.model.service.RankService;
import com.ssafy.yourpilling.rank.model.service.mapper.RankServiceMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import static java.time.LocalDateTime.*;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class RankServiceImpl implements RankService {

    private final static int LIMIT = 5;

    private final RankDao rankDao;
    private final RankServiceMapper mapper;

    @Scheduled(cron = "0 30 10 * * SUN")
    @Override
    public void generateWeeklyRank() {
        int weeks = Calendar.getInstance().getWeekYear();
        int year = LocalDate.now().getYear();

        List<Rank> infos = new ArrayList<>();

        // 나이 및 성별
        ageAndGenderRank(weeks, year, infos);

        // 영양소
        nutrientRank(weeks, year, infos);

        // 건강고민

        rankDao.registerAll(infos);
    }

    private void ageAndGenderRank(int weeks, int year, List<Rank> infos) {
        for (Gender g : Gender.values()) {
            for (AgeGroup a : AgeGroup.values()) {
                String midCategoryName = a.getRange() + "," + g.getGender();

                List<EachCountPerPill> each =
                        rankDao.rankAgeAndGender(a.getStartAge(), a.getEndAge(), g.getGender());

                limitSave(weeks, year, infos, each, getMidCategory(midCategoryName));
            }
        }
    }

    private void nutrientRank(int weeks, int year, List<Rank> infos){
        for (Nutrient n : Nutrient.values()) {
            List<EachCountPerPill> each = rankDao.rankNutrition(n.getEnglish());

            limitSave(weeks, year, infos, each, getMidCategory(n.getEnglish()));
        }
    }

    private RankMidCategory getMidCategory(String midCategoryName) {
        return rankDao.searchMidCategoryByMidCategoryName(midCategoryName);
    }

    private void limitSave(int weeks, int year, List<Rank> infos, List<EachCountPerPill> each, RankMidCategory midCategoryId) {
        for(int i = 0; i<Math.min(LIMIT, each.size()); i++){
            RankPill rankPill = rankDao.searchPillByPillId(each.get(i).getPillId());

            Rank save = mapper.mapToRank(weeks, year, i, rankPill, midCategoryId, now());
            infos.add(save);
        }
    }
}
