package com.ssafy.yourpilling.pill_heeju.model.dao.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "pill")
@Builder
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class PillDetail {
    @Id
    @Column(name = "pill_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long pillId;

    @Column
    private String name;

    @Column
    private String manufacturer;

    @Column
    private LocalDate expirationAt;

    @Column
    private String usageInstructions;

    @Column
    private String primaryFunctionality;

    @Column
    private String precautions;

    @Column
    private String storageInstructions;

    @Column
    private String standardSpecification;

    @Column
    private String productForm;

    @Column
    private String imageUrl;

    @Column
    private float takeCount;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @OneToMany( mappedBy = "pillDetail") // nutrition 테이블의 pill_id (FK)
    private List<NutritionDetail> NutritionDetail = new ArrayList<>();
}

