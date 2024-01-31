package com.ssafy.yourpilling.pill_heeju.model.dao.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "midcategory")
@Builder
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class HMidCategory {
    @Id
    @Column(name = "mid_category_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long midCategoryId;

    @Column(name = "category_nm")
    private String categoryNm;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @ManyToOne
    @JoinColumn(name = "big_category_id")
    private HBigCategory bigCategory;

    @OneToMany(mappedBy = "midCategory", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<HPillCategory> pillCategories;
}

