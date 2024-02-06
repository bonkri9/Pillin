package com.ssafy.yourpilling.pill_heeju.model.dao.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "ownpill")
@Builder
@Getter
@Setter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class HOwnPill {

    @Id
    @Column(name = "own_pill_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long ownPillId;

    @ManyToOne
    @JoinColumn(name = "member_id")
    private HPillMember member;

    @ManyToOne
    private HPill pill;
}
