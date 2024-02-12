package com.ssafy.yourpilling.takerhistory.model.dao.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Table(name="ownpill")
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class TakerHistoryOwnPill {

    @Id
    @Column(name = "own_pill_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long ownPillId;

    @Column(name = "take_count")
    private Integer takeCount;

    @Column(name = "remains")
    private Integer remains;

    @Column(name = "take_once_amount")
    private Integer takeOnceAmount;

    @Column(name = "take_weekdays")
    private Integer takeWeekdays;

    @Column(name = "take_yn")
    private boolean takeYn;

    @ManyToOne
    @JoinColumn(name = "member_id")
    private TakerHistoryPillMember member;

    @OneToMany(mappedBy = "ownPill")
    private List<TakerHistoryTakerHistory> takerHistories;

    @ManyToOne
    private TakerHistoryPill pill;
}
