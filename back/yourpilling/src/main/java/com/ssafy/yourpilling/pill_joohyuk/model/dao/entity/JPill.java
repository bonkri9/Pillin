package com.ssafy.yourpilling.pill_joohyuk.model.dao.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "pill")
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class JPill {

    @Id
    @Column(name = "pill_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long pillId;

    @Column(name = "name")
    private String name;

    @Column(name = "take_count")
    private Integer takeCount;

    @Column(name = "take_cycle")
    private Integer takeCycle;

    @Column(name = "take_once_amount")
    private Integer takeOnceAmount;

}
