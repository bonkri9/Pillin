package com.ssafy.yourpilling.pill.model.service.impl;

import com.ssafy.yourpilling.common.RunOutWarning;
import com.ssafy.yourpilling.common.TakeWeekday;
import com.ssafy.yourpilling.pill.model.dao.PillDao;
import com.ssafy.yourpilling.pill.model.dao.entity.OwnPill;
import com.ssafy.yourpilling.pill.model.dao.entity.PillMember;
import com.ssafy.yourpilling.pill.model.service.PillService;
import com.ssafy.yourpilling.pill.model.service.mapper.PillServiceMapper;
import com.ssafy.yourpilling.pill.model.service.mapper.value.OwnPillRegisterValue;
import com.ssafy.yourpilling.pill.model.service.vo.in.OwnPillUpdateVo;
import com.ssafy.yourpilling.pill.model.service.vo.in.PillDetailVo;
import com.ssafy.yourpilling.pill.model.service.vo.in.PillInventoryListVo;
import com.ssafy.yourpilling.pill.model.service.vo.in.PillRegisterVo;
import com.ssafy.yourpilling.pill.model.service.vo.out.OutOwnPillDetailVo;
import com.ssafy.yourpilling.pill.model.service.vo.out.OutPillInventorListVo;
import com.ssafy.yourpilling.pill.model.service.vo.out.OutPillInventorListVo.ResponsePillInventorListData;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.ArrayList;
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

    @Override
    public OutOwnPillDetailVo detail(PillDetailVo vo) {
        OwnPill ownPill = pillDao.findByOwnPillId(vo.getOwnPillId());
        return mapper.mapToOutOwnPillDetailVo(
                ownPill,
                runOutMessage(ownPill),
                takeWeekDays(ownPill.getTakeWeekdays()));
    }

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

    @Transactional
    @Override
    public void update(OwnPillUpdateVo vo) {
        OwnPill ownPill = pillDao.findByOwnPillId(vo.getOwnPillId());

        updateValues(vo, ownPill);
    }

    @Override
    public OutPillInventorListVo inventoryList(PillInventoryListVo vo) {
        PillMember member = pillDao.findByMemberId(vo.getMemberId());

        Map<Boolean, List<OwnPill>> partition = ownPillsYN(member.getOwnPills());

        return mapper.mapToResponsePillInventorListVo(
                calculationPredicateRunOut(partition.get(true)),
                calculationPredicateRunOut(partition.get(false)));
    }

    private static void updateValues(OwnPillUpdateVo vo, OwnPill ownPill) {
        ownPill.setRemains(vo.getRemains());
        ownPill.setTotalCount(vo.getTotalCount());
        ownPill.setTakeCount(vo.getTakeCount());
        ownPill.setTakeOnceAmount(vo.getTakeOnceAmount());
        ownPill.setTakeYN(vo.getTakeYn());
        ownPill.setStartAt(vo.getStartAt());

        if(vo.getTakeYn()) {
            ownPill.setTakeWeekdays(TakeWeekday.toValue(vo.getTakeWeekdays()));
        }else{
            ownPill.setTakeWeekdays(null);
        }

    }

    private Map<Boolean, List<OwnPill>> ownPillsYN(List<OwnPill> ownPills) {
        return ownPills
                .parallelStream()
                .collect(Collectors.partitioningBy(OwnPill::isTakeYN));
    }

    private ResponsePillInventorListData calculationPredicateRunOut(List<OwnPill> ownPills) {
        List<String> imageUrls = imageUrls(ownPills);
        List<LocalDate> predicateRunOutAts = predicateRunOutAts(ownPills);

        if ((ownPills.size() != imageUrls.size()) || (ownPills.size() != predicateRunOutAts.size())) {
            throw new RuntimeException("예상 재고 소진일 계산도중 오류가 발생했습니다.");
        }

        return mapper.mapToResponsePillInventorListData(ownPills, imageUrls, predicateRunOutAts);
    }

    private List<String> imageUrls(List<OwnPill> ownPills) {
        List<String> images = new ArrayList<>();
        for (OwnPill ownPill : ownPills) {
            images.add(ownPill.getPill().getImageUrl());
        }
        return images;
    }

    private List<LocalDate> predicateRunOutAts(List<OwnPill> ownPills) {
        List<LocalDate> at = new ArrayList<>();
        for (OwnPill ownPill : ownPills) {
            at.add(predicateRunOutAt(ownPill));
        }
        return at;
    }

    private LocalDate predicateRunOutAt(OwnPill ownPill) {
        if (!ownPill.getTakeYN()) {
            return null;
        }
        return LocalDate.now().plusDays(runOutAt(ownPill));
    }

    private int runOutAt(OwnPill ownPill) {
        int remains = ownPill.getRemains();
        int nextDay = LocalDate.now().getDayOfWeek().getValue();
        int after = 0;

        while (remains > 0) {
            after++;
            if ((ownPill.getTakeWeekdays() & (1 << nextDay)) == 0) continue;

            remains -= (ownPill.getTakeCount() * ownPill.getTakeOnceAmount());
            nextDay = ((nextDay + 1) % WEEK);
        }
        return after;
    }

    private List<String> takeWeekDays(Integer value) {
        return TakeWeekday.toTakeWeekdays(value);
    }

    private String runOutMessage(OwnPill ownPill) {
        if (!ownPill.isTakeYN()) return null;

        return RunOutWarning.getMessage((double) ownPill.getRemains() / ownPill.getTotalCount());
    }
}
