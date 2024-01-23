package com.ssafy.yourpilling.pill.model.dao.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "nutrition")
@Builder
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class Nutrition {

    @Id
    @Column(name = "nutrition_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long nutritionId;

    @Column
    private String nutrition;

    @Column
    private Double amount;

    @Column
    private String unit;

    @Column(name = "include_percent")
    private String includePercent;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @ManyToOne
    @JoinColumn(name = "pill_pill_id")
    private Pill pill;
}
