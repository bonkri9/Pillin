package com.ssafy.yourpilling.pill.model.service.impl;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import com.ssafy.yourpilling.common.TakeWeekday;
import com.ssafy.yourpilling.pill.model.dao.OwnPillDao;
import com.ssafy.yourpilling.pill.model.dao.entity.*;
import com.ssafy.yourpilling.pill.model.service.OwnPillService;
import com.ssafy.yourpilling.pill.model.service.dto.TakerHistorySummary;
import com.ssafy.yourpilling.pill.model.service.mapper.OwnPillServiceMapper;
import com.ssafy.yourpilling.pill.model.service.mapper.value.OwnPillRegisterValue;
import com.ssafy.yourpilling.pill.model.service.vo.in.*;
import com.ssafy.yourpilling.pill.model.service.vo.out.*;
import com.ssafy.yourpilling.pill.model.service.vo.out.OutOwnPillInventorListVo.ResponsePillInventorListData;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;

import static java.time.LocalDateTime.now;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class OwnOwnPillServiceImpl implements OwnPillService {

    private static final int WEEK = 7;

    private final OwnPillDao ownPillDao;
    private final OwnPillServiceMapper mapper;

    private final FirebaseMessaging firebaseMessaging;
    private final String PUSH_TITLE = "Pillin";
    private final String PUSH_IMAGE = "https://www.google.com/url?sa=i&url=https%3A%2F%2Fpixabay.com%2Fko%2Fimages%2Fsearch%2F%25EC%2598%2581%25EC%2596%2591%25EC%25A0%259C%2F&psig=AOvVaw2J4FYwok9I3UwNP5WIPR-_&ust=1706684262130000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCNiij7vEhIQDFQAAAAAdAAAAABAE";
    private final String REPURCHASE_PUSH_MESSAGE = "재구매 시기가 다가온 영양제가 있습니다!";

    @Override
    public OutOwnPillDetailVo detail(OwnPillDetailVo vo) {
        OwnPill ownPill = ownPillDao.findByOwnPillId(vo.getOwnPillId());
        return mapper.mapToOutOwnPillDetailVo(
                ownPill,
                ownPill.runOutMessage(),
                takeWeekDays(ownPill.getTakeWeekdays()));
    }

    @Override
    public OutOwnPillInventorListVo inventoryList(OwnPillInventoryListVo vo) {
        PillMember member = ownPillDao.findByMemberId(vo.getMemberId());

        Map<Boolean, List<OwnPill>> partition = OwnPill.ownPillsYN(member.getOwnPills());

        sortByRemains(partition.get(true));

        return mapper.mapToResponsePillInventorListVo(
                calculationPredicateRunOut(partition.get(true)),
                calculationPredicateRunOut(partition.get(false)));
    }

    private static void sortByRemains(List<OwnPill> partition) {
            partition.sort(Comparator.comparing(OwnPill::getRemains));
    }

    @Transactional
    @Override
    public void register(OwnPillRegisterVo vo) {
        ownPillDao.isAlreadyRegister(vo.getMemberId(), vo.getPillId());


        int adjustRemain = Math.max(vo.getRemains(), 0);
        boolean adjustIsTaken = (adjustRemain > 0) ? vo.getTakeYn() : false;
        OwnPillRegisterValue value = mapToOwnPillRegisterValue(vo, adjustRemain, adjustIsTaken);

        OwnPill registOwnPill = mapper.mapToOwnPill(value);
        ownPillDao.register(registOwnPill);

        if(adjustIsTaken) {
            OwnPill ownPill = ownPillDao.findByOwnPillId(registOwnPill.getOwnPillId());
            makeTakerHistoryIfAbsent(ownPill);
        }

    }

    @Transactional
    @Override
    public void update(OwnPillUpdateVo vo) {
        if(isUpdateVoInvalid(vo)) throw new IllegalArgumentException("잘못된 재고 수정 요청입니다.");
        ownPillDao.update(vo);
    }

    private boolean isUpdateVoInvalid(OwnPillUpdateVo vo) {
        return vo.getRemains() == null || vo.getTotalCount() == null|| vo.getTotalCount() < vo.getRemains();
    }

    @Transactional
    @Override
    public void remove(OwnPillRemoveVo vo) {
        ownPillDao.removeByOwnPillId(vo.getOwnPillId());
    }

    @Transactional
    @Override
    public OutOwnPillTakeVo take(OwnPillTakeVo ownPillTakeVo) {
        boolean needToUpdate = false;
         OwnPill ownPill = ownPillDao.takeByOwnPillId(ownPillTakeVo.getOwnPillId());

         if(ownPill.getRemains() == 0) {
             throw new IllegalArgumentException("더 이상 복용할 수 없습니다.");
         }

        for(TakerHistory th : ownPill.getTakerHistories()) {
            if(th.getTakeAt().equals(LocalDate.now())) {
                if(th.getCurrentTakeCount() >= th.getNeedToTakeCount()) {
                    throw new IllegalArgumentException("더 이상 복용할 수 없습니다.");
                }

                th.increaseCurrentTakeCount(ownPill.getTakeOnceAmount());

                if(th.getCurrentTakeCount() >= th.getNeedToTakeCount()) {
                    needToUpdate = true;
                }
                break;
            }
        }

        // TODO: 영양제 일정 개수 이하로 떨어지면 재구매 알림
        if(ownPill.getRemains() <= 10){
            try{
                reBuyAlarm(ownPill.getMember().getDeviceTokens());
            }catch (Exception e){
                e.printStackTrace();
            }

        }
 
        return OutOwnPillTakeVo
                .builder()
                .needToUpdateWeeklyHistory(needToUpdate)
                .build();
    }

    private void reBuyAlarm(List<PillDeviceToken> deviceTokens) {

            for (PillDeviceToken deviceToken : deviceTokens) {
                System.out.println(deviceToken);
                Message fcmMessage = Message
                        .builder()
                        .setNotification(getNotification(REPURCHASE_PUSH_MESSAGE))
                        .setToken(deviceToken.getDeviceToken())
                        .build();

                try {
                    firebaseMessaging.send(fcmMessage);
                } catch (FirebaseMessagingException e) {
                    e.printStackTrace();
                }

        }


    }

    @Transactional
    @Override
    public void takeAll(Long memberId) {

        List<OwnPill> ownPills = ownPillDao.findByMemberId(memberId).getOwnPills();
        for(OwnPill ownPill : ownPills) {
            for(TakerHistory th : ownPill.getTakerHistories()) {
                if(th.getTakeAt().equals(LocalDate.now())) {

                    int amountToTakeAll = th.getNeedToTakeCount() - th.getCurrentTakeCount();
                    ownPill.decreaseAllTake(amountToTakeAll);
                    th.increaseCurrentTakeCount(amountToTakeAll);

                    break;
                }
            }
        }

    }

    @Override
    public OutWeeklyTakerHistoryVo weeklyTakerHistory(WeeklyTakerHistoryVo weeklyTakerHistoryVo) {
        return ownPillDao.findWeeklyTakerHistoriesByMemberId(weeklyTakerHistoryVo);
    }

    @Override
    public OutMonthlyTakerHistoryVo monthlyTakerHistory(MonthlyTakerHistoryVo monthlyTakerHistoryVo) {
        List<MonthlyTakerHistory> list = ownPillDao.findMonthlyTakerHistoriesByMemberIdAndDate(monthlyTakerHistoryVo);

        HashMap<LocalDate, TakerHistorySummary> response = new HashMap<>();

        for(MonthlyTakerHistory mth : list) {
            if(mth.isInvalid()) continue;
            response.putIfAbsent(mth.getTakeAt(), new TakerHistorySummary(0, 0, new ArrayList<MonthlyTakerHistory>()));
            TakerHistorySummary ths = response.get(mth.getTakeAt());
            ths.increaseActualTakenCount(mth.getCurrentTakeCount());
            ths.increaseNeedToTakenCount(mth.getNeedToTakeCount());
            ths.addTakerHistory(mth);
        }

        return OutMonthlyTakerHistoryVo
                .builder()
                .data(response)
                .build();
    }

    @Transactional
    @Override
    public void updateTakeYn(OwnPillTakeYnVo ownPillTakeYnVo) {


        OwnPill ownPill = ownPillDao.findByOwnPillId(ownPillTakeYnVo.getOwnPillId());

        TakerHistory todayHistory = makeTakerHistoryIfAbsent(ownPill);

        if(ownPill.getTakeYN()) {

            // 섭취에서 미섭취로 전환
            ownPill.setTakeYN(false);
            todayHistory.decreaseNeedToTakeByUpdateTakeYn();
        } else {

            // 미섭취에서 섭취로 전환
            ownPill.setTakeYN(true);
            todayHistory.increaseNeedToTakeByUpdateTakeYn();

        }
    }

    @Transactional
    @Override
    public void buyRecord(BuyRecordVo vo) {
        ownPillDao.buyRecord(mapper.mapToBuyRecord(vo));
    }

    private TakerHistory makeTakerHistoryIfAbsent(OwnPill ownPill) {
        LocalDate today = LocalDate.now();
        TakerHistory todayHistory = null;

        if(ownPill.getTakerHistories() == null) {
            todayHistory = registTakerHistory(ownPill, today);
            return todayHistory;
        }

        for (TakerHistory th : ownPill.getTakerHistories()) {
            if (th.getTakeAt().equals(today)) {
                todayHistory = th;
                break;
            }
        }

        if (todayHistory == null) {
            todayHistory = registTakerHistory(ownPill, today);
        }

        return todayHistory;
    }

    private TakerHistory registTakerHistory(OwnPill ownPill, LocalDate today) {
        TakerHistory todayHistory;
        todayHistory = TakerHistory
                .builder()
                .needToTakeCount(ownPill.getTakeCount())
                .currentTakeCount(0)
                .createdAt(LocalDateTime.now())
                .takeAt(today)
                .ownPill(ownPill)
                .build();

        // 오늘의 일일 복용 기록 생성!!
        ownPillDao.registerHistory(todayHistory);
        return todayHistory;
    }

    private OwnPillRegisterValue mapToOwnPillRegisterValue(OwnPillRegisterVo vo, int adjustRemain, boolean adjustIsTaken) {

        if(isOwnPillRegisterVoInvalid(vo)) throw new IllegalArgumentException("잘못된 재고 등록 요청입니다.");

        Pill pill = ownPillDao.findByPillId(vo.getPillId());

        return OwnPillRegisterValue
                .builder()
                .adjustRemain(adjustRemain)
                .adjustIsTaken(adjustIsTaken)
                .member(ownPillDao.findByMemberId(vo.getMemberId()))
                .pill(pill)
                .isAlarm(false)
                .createAt(now())
                .takeWeekDaysValue(TakeWeekday.toValue(vo.getTakeWeekdays()))
                .totalCount(vo.getTotalCount())
                .takeCount(pill.getTakeCount())
                .takeOnceAmount(pill.getTakeOnceAmount())
                .build();
    }

    private boolean isOwnPillRegisterVoInvalid(OwnPillRegisterVo vo) {
        return vo.getTotalCount() == null || vo.getTakeYn() == null || vo.getTakeWeekdays() == null
                || vo.getRemains() == null || vo.getRemains() > vo.getTotalCount();
    }

    private ResponsePillInventorListData calculationPredicateRunOut(List<OwnPill> ownPills) {
        List<String> imageUrls = OwnPill.imageUrls(ownPills);
        List<LocalDate> predicateRunOutAts = OwnPill.predicateRunOutAts(ownPills, WEEK);

        if ((ownPills.size() != imageUrls.size()) || (ownPills.size() != predicateRunOutAts.size())) {
            throw new RuntimeException("예상 재고 소진일 계산도중 오류가 발생했습니다.");
        }

        return mapper.mapToResponsePillInventorListData(ownPills, imageUrls, predicateRunOutAts);
    }

    private List<String> takeWeekDays(Integer value) {
        return TakeWeekday.toTakeWeekdays(value);
    }

    private Notification getNotification(String message) {
        return Notification
                .builder()
                .setTitle(PUSH_TITLE)
                .setBody(message)
                .setImage(PUSH_IMAGE)
                .build();
    }


}
