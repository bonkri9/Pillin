package com.ssafy.yourpilling.rank.model.dao.impl;

import com.ssafy.yourpilling.common.Gender;
import com.ssafy.yourpilling.rank.model.dao.entity.EachCountPerPill;
import com.ssafy.yourpilling.rank.model.dao.jpa.RankPillMemberRepository;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

import java.util.List;

@SpringBootTest
@ActiveProfiles("dev")
class RankDaoImplTest {

    @Autowired
    private RankPillMemberRepository rankPillMemberRepository;

    @Test
    @Disabled
    @DisplayName("모든 사용자들이 보유중인 영양제 정보")
    public void rankCal(){
        // given, when
        List<EachCountPerPill> eachCountPerPills =
                rankPillMemberRepository.countPillTotalMember(20, 20, Gender.MAN.getGender());

        // then
        System.out.println("[total size] : " + eachCountPerPills.size());
        for (EachCountPerPill each : eachCountPerPills) {
            System.out.println("pillId : " + each.getPillId());
            System.out.println("size : " + each.getPillCount());
        }
    }
}