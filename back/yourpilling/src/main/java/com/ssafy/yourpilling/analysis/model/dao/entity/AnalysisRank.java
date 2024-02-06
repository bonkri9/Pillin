package com.ssafy.yourpilling.analysis.model.dao.entity;

import com.ssafy.yourpilling.rank.model.dao.entity.RankPill;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "ranks")
@Builder
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
@ToString
public class AnalysisRank {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "rank_id")
    private Long rankId;

    @Column
    private Integer weeks;

    @Column
    private Integer year;

    @Column
    private Integer rank;

    @Column(name = "created_at")
    private LocalDateTime createAt;

    @Column(name = "updated_at")
    private LocalDateTime updateAt;

    @ManyToOne
    @JoinColumn(name = "pill_id")
    private AnalysisPill pill;

    @ManyToOne
    @JoinColumn(name = "mid_category_id")
    private AnalysisRankMidCategory midCategory;
}
