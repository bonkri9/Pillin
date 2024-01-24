package com.ssafy.yourpilling.pill.model.service.impl;

import com.ssafy.yourpilling.common.TakeWeekday;
import com.ssafy.yourpilling.pill.model.dao.PillDao;
import com.ssafy.yourpilling.pill.model.dao.entity.OwnPill;
import com.ssafy.yourpilling.pill.model.dao.entity.Pill;
import com.ssafy.yourpilling.pill.model.dao.entity.PillMember;
import com.ssafy.yourpilling.pill.model.service.PillService;
import com.ssafy.yourpilling.pill.model.service.mapper.PillServiceMapper;
import com.ssafy.yourpilling.pill.model.service.mapper.value.OwnPillRegisterValue;
import com.ssafy.yourpilling.pill.model.service.vo.request.PillInventoryListVo;
import com.ssafy.yourpilling.pill.model.service.vo.request.PillRegisterVo;
import com.ssafy.yourpilling.pill.model.service.vo.response.ResponsePillInventorListVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static java.time.LocalDateTime.now;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class PillServiceImpl implements PillService {

    private static final int WEEK = 7;

    private final PillDao pillDao;
    private final PillServiceMapper mapper;

    @Transactional
    @Override
    public void register(PillRegisterVo vo) {
        OwnPillRegisterValue value = OwnPillRegisterValue
                .builder()
                .vo(vo)
                .member(pillDao.findByMemberId(vo.getMemberId()))
                .pill(pillDao.findByPillId(vo.getPillId()))
                .isAlarm(false)
                .createAt(now())
                .takeWeekDaysValue(TakeWeekday.toValue(vo.getTakeWeekdays()))
                .takeOnceAmount(vo.getTakeOnceAmount())
                .build();

        pillDao.register(mapper.mapToOwnPill(value));
    }

    @Override
    public ResponsePillInventorListVo inventoryList(PillInventoryListVo pillInventoryListVo) {
        PillMember member = pillDao.findByMemberId(pillInventoryListVo.getMemberId());

        Map<Boolean, List<OwnPill>> takeYn = ownPillsYN(member.getOwnPills());
        List<OwnPill> takeTrue = takeYn.get(true);
        List<OwnPill> takeFalse = takeYn.get(false);

        // TODO: 예상 재고 소진 시기


        return null;
    }

    private Map<Boolean, List<OwnPill>> ownPillsYN(List<OwnPill> ownPills){
        return ownPills
                .parallelStream()
                .collect(Collectors.partitioningBy(OwnPill::isTakeYN));
    }

    // TODO: 복용 이력 기능 완성 후 계산 로직 수정 필요
    private LocalDate predicateRunOut(OwnPill ownPill){
        // 현재 날짜 + (남은 개수 - 1일 복용량)
        Pill pill = ownPill.getPill();
        int remain = ownPill.getRemains(); // 남은 재고량
        int takeWeekdays = ownPill.getTakeWeekdays(); // 일주일 복용 주기
        int takeCount = ownPill.getTakeCount(); // 일일 복용 횟수
        int takeOnceAmount = ownPill.getTakeOnceAmount();

        int today = LocalDate.now().getDayOfWeek().getValue() - 1;

        // 이번주가 끝날때 까지 먹어야 하는 양
        int remainTakeUntilWeekEnd = weeklyTakeAmountSinceStart(today, ownPill.getTakeWeekdays());


        return null;
    }

    private int weeklyTakeAmountSinceStart(int start, int weeklyTake){
        int amount = 0;

        for(int i=start; i < WEEK; i++){
            if((weeklyTake & (i<<1)) == 0) continue;
            amount++;
        }
        return amount;
    }
}
