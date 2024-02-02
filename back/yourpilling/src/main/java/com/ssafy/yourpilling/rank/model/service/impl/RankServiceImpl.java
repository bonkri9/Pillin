package com.ssafy.yourpilling.rank.model.service.impl;

import com.ssafy.yourpilling.common.AgeGroup;
import com.ssafy.yourpilling.common.Gender;
import com.ssafy.yourpilling.common.HealthConcern;
import com.ssafy.yourpilling.common.Nutrient;
import com.ssafy.yourpilling.rank.model.dao.RankDao;
import com.ssafy.yourpilling.rank.model.dao.entity.*;
import com.ssafy.yourpilling.rank.model.service.RankService;
import com.ssafy.yourpilling.rank.model.service.mapper.RankServiceMapper;
import com.ssafy.yourpilling.rank.model.service.vo.wrap.CategoryCategoryVos;
import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.temporal.WeekFields;
import java.util.*;
import java.util.stream.Collectors;

import static java.time.LocalDateTime.now;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class RankServiceImpl implements RankService {

    private final static int LIMIT = 5;

    private final RankDao rankDao;
    private final RankServiceMapper mapper;

    @Override
    public CategoryCategoryVos categories() {
        List<AllCategories> allCategories = rankDao.allCategories();

        return mapper.mapToCategoryCategoryVos(allCategories);
    }

    @Scheduled(cron = "0 30 10 * * SUN")
    @Transactional
    @Override
    public void generateWeeklyRank() {
        int weeks = (LocalDate.now().get(WeekFields.of(Locale.getDefault()).weekOfWeekBasedYear()) + 1)
                % Calendar.getInstance().getWeekYear();
        int year = LocalDate.now().getYear();

        List<Rank> infos = new ArrayList<>();

        // 나이 및 성별
        ageAndGenderRank(weeks, year, infos);

        // 영양소 및 건강고민
        nutrientAndHealthConcernRank(weeks, year, infos);

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

    private void nutrientAndHealthConcernRank(int weeks, int year, List<Rank> infos) {
        HealthConcern[] values = HealthConcern.values();
        Map<Long, Long>[] pillAmountPerHealthConcern = new Map[values.length];
        Arrays.fill(pillAmountPerHealthConcern, new HashMap<>());

        for (Nutrient n : Nutrient.values()) {
            List<EachCountPerPill> each = rankDao.rankNutrition(n.getEnglish());

            RankMidCategory midCategory = getMidCategory(n.getEnglish());

            List<Integer> healthConcernsIndex = n.getHealthConcernIndex();

            for (int i = 0; i < Math.min(LIMIT, each.size()); i++) {
                Long pillId = each.get(i).getPillId();
                Long count = each.get(i).getPillCount();

                RankPill rankPill = rankDao.searchPillByPillId(pillId);

                Rank save = mapper.mapToRank(weeks, year, i, rankPill, midCategory, now());
                infos.add(save);

                // 해당 영양소가 포함되는 건강 고민
                for (Integer concernsIndex : healthConcernsIndex) {
                    Map<Long, Long> pills = pillAmountPerHealthConcern[concernsIndex];
                    pills.put(pillId, pills.getOrDefault(pillId, 0L) + count); // 영양소 정보에 맞는 영양제 정보 삽입
                }
            }
        }

        // 건강 고민
        healthConcernRank(weeks, year, infos, pillAmountPerHealthConcern, values);
    }

    private void healthConcernRank(int weeks, int year, List<Rank> infos, Map<Long, Long>[] pillAmountPerHealthConcern, HealthConcern[] values) {
        for (int k = 0; k < pillAmountPerHealthConcern.length; k++) {
            Map<Long, Long> h = pillAmountPerHealthConcern[k]; // key: 영양제 번호, value : 영양제 총 량

            // 가장 많은 영양제를 가지고 있는 순으로 정렬
            List<Long> desc = new ArrayList<>(h.keySet());
            desc.sort((o1, o2) -> h.get(o2).compareTo(h.get(o1)));

            for (int i = 0; i < Math.min(LIMIT, desc.size()); i++) {
                RankPill rankPill = rankDao.searchPillByPillId(desc.get(i));

                Rank save = mapper.mapToRank(weeks, year, i, rankPill, getMidCategory(values[k].getEnglish()), now());
                infos.add(save);
            }
        }
    }

    private RankMidCategory getMidCategory(String midCategoryName) {
        return rankDao.searchMidCategoryByMidCategoryName(midCategoryName);
    }

    private void limitSave(int weeks, int year, List<Rank> infos, List<EachCountPerPill> each, RankMidCategory midCategory) {
        for (int i = 0; i < Math.min(LIMIT, each.size()); i++) {
            RankPill rankPill = rankDao.searchPillByPillId(each.get(i).getPillId());

            Rank save = mapper.mapToRank(weeks, year, i + 1, rankPill, midCategory, now());
            infos.add(save);
        }
    }
}
