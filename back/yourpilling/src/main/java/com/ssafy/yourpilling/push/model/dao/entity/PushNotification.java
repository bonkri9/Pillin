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
    private int pushDay;

    @Column(name = "hour")
    private int hour;

    @Column(name = "minute")
    private int minute;

    @ManyToOne
    @JoinColumn(name = "member_id")
    private PushMember member;


}
