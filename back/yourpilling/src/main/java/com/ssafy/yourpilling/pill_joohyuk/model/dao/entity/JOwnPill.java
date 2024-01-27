package com.ssafy.yourpilling.pill_joohyuk.model.dao.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Table(name = "ownpill")
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class JOwnPill {

    @Id
    @Column(name = "own_pill_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long ownPillId;

    @Column(name = "take_count")
    private Integer takeCount;

    @Column(name = "take_once_amount")
    private Integer takeOnceAmount;

    @ManyToOne
    @JoinColumn(name = "member_id")
    private JPillMember member;

    // 연관관계 주인 설정
    @OneToMany(mappedBy = "ownPill")
    private List<JTakerHistory> takerHistories;

    // 단방향이기 때문에 연관관계 주인 설정을 할 필요가 없다.
    @OneToOne
    private JPill pill;

}
