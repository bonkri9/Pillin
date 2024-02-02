package com.ssafy.yourpilling.push.model.dao.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "messageinfos")
@Builder
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class PushMessageInfo {

    @Id
    @Column(name = "message_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long messageId;

    @Column(name = "push_day")
    private int pushDay;

    @ManyToOne
    @JoinColumn(name = "push_id")
    private PushNotification pushNotification;


}
