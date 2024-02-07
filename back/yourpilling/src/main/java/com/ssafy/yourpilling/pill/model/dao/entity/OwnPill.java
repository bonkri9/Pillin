package com.ssafy.yourpilling.pill.model.dao.entity;

import com.ssafy.yourpilling.common.RunOutWarning;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Entity
@Table(name = "ownpill")
@Builder
@Getter
@Setter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class OwnPill {

    @Id
    @Column(name = "own_pill_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long ownPillId;

    @Column
    private Integer remains;

    @Column(name = "take_count")
    private Integer takeCount;

    @Column(name = "take_weekdays")
    private Integer takeWeekdays; // 한 주 동안 복용 주기(월, 화, ...)

    @Column(name = "total_count")
    private Integer totalCount; // 일일 복용 횟수(1회, 2회, ...)

    @Column(name = "take_once_amount")
    private Integer takeOnceAmount; // 1회 섭취 량(1정, 2정, ...)

    @Column(name = "is_alarm")
    private Boolean isAlarm;

    @Column(name = "take_yn")
    private Boolean takeYN;

    @Column(name = "start_at")
    private LocalDate startAt;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @ManyToOne
    @JoinColumn(name = "member_id")
    private PillMember member;

    @ManyToOne
    private Pill pill;

    // 연관관계 주인 설정
    @OneToMany(mappedBy = "ownPill", fetch = FetchType.LAZY)
    private List<TakerHistory> takerHistories;

    public void setMember(PillMember member) {
        this.member = member;

//        if(!member.getOwnPills().contains(this)){
//            member.getOwnPills().add(this);
//        }
    }

    public boolean isTakeYN() {
        return this.takeYN;
    }

    public static Map<Boolean, List<OwnPill>> ownPillsYN(List<OwnPill> ownPills) {
        return ownPills
                .stream()
                .collect(Collectors.partitioningBy(OwnPill::isTakeYN));
    }

    public String runOutMessage() {
        if (!this.isTakeYN()) return null;

        return RunOutWarning.getMessage(((double) this.getRemains() / this.getTotalCount()) * 100);
    }

    public static List<String> imageUrls(List<OwnPill> ownPills) {
        List<String> images = new ArrayList<>();
        for (OwnPill ownPill : ownPills) {
            images.add(ownPill.getPill().getImageUrl());
        }
        return images;
    }

    public static List<LocalDate> predicateRunOutAts(List<OwnPill> ownPills, Integer week) {
        List<LocalDate> at = new ArrayList<>();
        for (OwnPill ownPill : ownPills) {
            at.add(ownPill.predicateRunOutAt(week));
        }
        return at;
    }

    public LocalDate predicateRunOutAt(Integer week) {
        if (!this.getTakeYN()) {
            return null;
        }
        return LocalDate.now().plusDays(runOutAt(week));
    }

    private int runOutAt(Integer week) {
        int remains = this.getRemains();
        int nextDay = LocalDate.now().getDayOfWeek().getValue()%week;
        int after = 0;

        while (remains > 0) {
            after++;
            if ((this.getTakeWeekdays() & (1 << nextDay)) == 0) continue;

            remains -= (this.getTakeCount() * this.getTakeOnceAmount());
            nextDay = ((nextDay + 1) % week);
        }
        return after;
    }

    public int decreaseRemains() {

        int returnVal = this.takeOnceAmount;

        if(this.remains - this.takeOnceAmount > 0) {
            this.remains -= this.takeOnceAmount;
        }
        else if(this.remains - this.takeOnceAmount < 0) {
            returnVal = this.remains;
            this.remains = 0;
            this.takeYN = false;
        }
        else {
            this.takeYN = false;
        }

        return returnVal;
    }
}
