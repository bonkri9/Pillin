package com.ssafy.yourpilling.takerhistory.model.dao.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Table(name = "members")
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class TakerHistoryPillMember {

    @Id
    @Column(name = "member_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long memberId;

    @OneToMany(mappedBy = "member")
    private List<TakerHistoryOwnPill> takerHistoryOwnPills;

}
