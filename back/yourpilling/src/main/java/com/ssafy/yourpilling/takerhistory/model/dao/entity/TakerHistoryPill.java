package com.ssafy.yourpilling.takerhistory.model.dao.entity;


import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "pill")
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class TakerHistoryPill {

    @Id
    @Column(name = "pill_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long pillId;

    @Column(name = "name")
    private String name;

}
