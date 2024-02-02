package com.ssafy.yourpilling.rank.model.dao.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "ranks")
@Builder
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class RankBigCategory {

    @Id
    @Column(name = "rank_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long bigCategoryId;

    @Column(name = "category_nm")
    private String categoryNm;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @OneToMany(mappedBy = "bigCategory")
    private List<RankMidCategory> midCategories;
}
