package com.ssafy.yourpilling.pill.model.dao.entity;

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
public class MidCategory {
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
    private BigCategory bigCategory;

    @OneToMany(mappedBy = "midCategory", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<PillCategory> pillCategories;
}

