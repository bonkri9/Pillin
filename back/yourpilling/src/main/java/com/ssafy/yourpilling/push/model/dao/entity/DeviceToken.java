package com.ssafy.yourpilling.push.model.dao.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "devicetoken")
@Builder
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
@ToString
public class DeviceToken {

    @Id
    @Column(name = "token_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long tokenId;

    @Column(name = "device_token")
    private String deviceToken;

    @ManyToOne
    @JoinColumn(name = "member_id")
    private PushMember member;

}
