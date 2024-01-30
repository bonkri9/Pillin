package com.ssafy.yourpilling.rank.model.dao.entity;

import com.ssafy.yourpilling.pill.model.dao.entity.PillMember;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "ownpill")
@Builder
@Getter
@Setter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class RankOwnPill {

    @Id
    @Column(name = "own_pill_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long ownPillId;

    @ManyToOne
    @JoinColumn(name = "member_id")
    private PillMember member;

    @ManyToOne
    private RankPill pill;
}
