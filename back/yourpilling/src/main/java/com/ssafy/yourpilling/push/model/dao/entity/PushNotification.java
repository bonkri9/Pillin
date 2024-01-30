package com.ssafy.yourpilling.push.model.dao.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "takepushmessages")
@Builder
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class PushNotification {

    @Id
    @Column(name = "push_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long pushId;

    @Column(name = "message")
    private String message;

    @Column(name = "push_day")
    private Byte pushDay;

    @Column(name = "push_time")
    private LocalDateTime pushTime;

    @ManyToOne
    @JoinColumn(name = "member_id")
    private PushMember member;


}
