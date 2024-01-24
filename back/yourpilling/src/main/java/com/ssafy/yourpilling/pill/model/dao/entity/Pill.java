package com.ssafy.yourpilling.pill.model.dao.entity;

import com.ssafy.yourpilling.common.PillProductForm;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "pill")
@Builder
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class Pill {

    @Id
    @Column(name = "pill_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long pillId;

    @Column
    private String name;

    @Column
    private String manufacturer;

    @Column(name = "expiration_at")
    private LocalDate expirationAt;

    @Column(name = "usage_instructions")
    private String usageInstructions;

    @Column(name = "primary_functionality")
    private String primaryFunctionality;

    @Column
    private String precautions;

    @Column(name = "storage_instructions")
    private String storageInstructions;

    @Column(name = "standard_specification")
    private String standardSpecification;

    @Column(name = "product_form")
    @Enumerated(EnumType.STRING)
    private PillProductForm productForm;

    @Column(name = "image_url")
    private String imageUrl;

    @Column(name = "takeCount")
    private Double takeCount;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @OneToMany(mappedBy = "pill", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<Nutrition> nutritions;

    @OneToMany(mappedBy = "pill", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<PillCategory> pillCategories;
}
