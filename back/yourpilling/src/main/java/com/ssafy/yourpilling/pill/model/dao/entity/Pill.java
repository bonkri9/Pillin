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
    private String expirationAt;

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

    @Column(name = "take_count")
    private Integer takeCount;

    @Column(name = "take_cycle")
    private Integer takeCycle;

    @Column(name = "take_once_amount")
    private Integer takeOnceAmount;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @OneToMany(mappedBy = "pill", fetch = FetchType.LAZY)
    private List<Nutrition> nutritions;

    @OneToMany(mappedBy = "pill", fetch = FetchType.LAZY)
    private List<PillCategory> pillCategories;

    public void setNutritions(List<Nutrition> nutritions){
        this.nutritions = nutritions;

        if(nutritions == null) return;

        for (Nutrition nutrition : nutritions) {
            nutrition.setPill(this);
        }
    }
}
