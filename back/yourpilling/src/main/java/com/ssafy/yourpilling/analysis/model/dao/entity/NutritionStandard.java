package com.ssafy.yourpilling.analysis.model.dao.entity;

import com.ssafy.yourpilling.common.Gender;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;

@Entity
@Table(name = "nutritionstandard")
@Builder
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class NutritionStandard {
    @Id
    @Column(name = "standard_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long standardId;

    @Column(name = "nutrition_group")
    private String nutritionGroup;

    @Column(name = "nutrition_name")
    private String nutritionName;

    @Column(name = "gender")
    private String gender;

    @Column(name = "age_range")
    private String ageRange;

    @Column(name = "recommended_intake")
    private Double recommendedIntake;

    @Column(name = "sufficient_intake")
    private Double sufficientIntake;

    @Column(name = "excessive_intake")
    private Double excessiveIntake;

    @Column
    private String unit;

    @Column(name = "created_at")
    private LocalDate createdAt;

    @Column(name = "updated_at")
    private LocalDate updatedAt;

}
