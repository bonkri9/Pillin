package com.ssafy.yourpilling.rank.model.dao.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "nutrition")
@Builder
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
@ToString
public class RankNutrition {

    @Id
    @Column(name = "nutrition_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long nutritionId;

    @Column
    private String nutrition;

    @ManyToOne
    @JoinColumn(name = "pill_id")
    private RankPill pill;
}
