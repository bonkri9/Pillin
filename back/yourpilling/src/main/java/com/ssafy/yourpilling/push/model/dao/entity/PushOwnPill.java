package com.ssafy.yourpilling.push.model.dao.entity;

import com.ssafy.yourpilling.pill.model.dao.entity.Pill;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Table(name = "ownpill")
@Builder
@Getter
@Setter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class PushOwnPill {


        @Id
        @Column(name = "own_pill_id")
        @GeneratedValue(strategy = GenerationType.AUTO)
        private Long ownPillId;

        @Column(name = "take_yn")
        private Boolean takeYN;

        @Column(name = "remains")
        private int remains;

        @Column(name = "total_count")
        private int totalCount;


        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(name = "member_id")
        private PushMember member;

        @OneToMany(mappedBy = "pushOwnPill", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
        private List<PushNotification> pushNotifications;

        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(name = "pill_pill_id")
        private PushPill pushPill;

}
