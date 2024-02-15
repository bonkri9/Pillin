package com.ssafy.yourpilling.push.model.dao.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Table(name = "notifications")
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

    @Setter
    @Column(name = "push_hour")
    private int pushHour;

    @Setter
    @Column(name = "push_minute")
    private int pushMinute;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "own_pill_id")
    private PushOwnPill pushOwnPill;

    @OneToMany(mappedBy = "pushNotification", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<PushMessageInfo> messageInfos;

    public void addMessageInfo(PushMessageInfo pushMessageInfo) {
        this.messageInfos.add(pushMessageInfo);
    }

}
