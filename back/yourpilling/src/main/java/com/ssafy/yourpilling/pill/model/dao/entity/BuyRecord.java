package com.ssafy.yourpilling.pill.model.dao.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "buyrecords")
@Builder
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class BuyRecord {

    @Id
    @Column(name = "buy_record_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long buyRecordId;

    @Column(name = "member_id")
    private Long memberId;

    @Column(name = "pill_id")
    private Long pillId;
}
