package com.ssafy.yourpilling.analysis.model.dao.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "ownpill")
@Builder
@Getter
@Setter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class AnalysisOwnPill {
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
    private Boolean takeYn;

    @Column(name = "start_at")
    private LocalDate startAt;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @ManyToOne
    @JoinColumn(name = "member_id")
    private AnalysisMember member;

    @ManyToOne
    private AnalysisPill pill;
}
