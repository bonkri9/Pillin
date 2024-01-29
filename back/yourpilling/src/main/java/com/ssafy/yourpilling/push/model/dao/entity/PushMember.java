package com.ssafy.yourpilling.push.model.dao.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;
@Entity
@Table(name = "members")
@Builder
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class PushMember {

        @Id
        @Column(name = "member_id")
        @GeneratedValue(strategy = GenerationType.AUTO)
        private Long memberId;

        @OneToMany(mappedBy = "member", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
        private List<DeviceToken> deviceTokens;
}
