package com.ssafy.yourpilling.analysis.model.dao.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "midcategory")
@Builder
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
@ToString
public class AnalysisRankMidCategory {

    @Id
    @Column(name = "mid_category_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long midCategoryId;

    @Column(name = "category_nm")
    private String categoryNm;

    @ManyToOne
    @JoinColumn(name = "big_category_id")
    private AnalysisRankBigCategory bigCategory;
}
