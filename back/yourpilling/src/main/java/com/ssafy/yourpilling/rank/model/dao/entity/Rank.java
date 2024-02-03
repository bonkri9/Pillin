package com.ssafy.yourpilling.rank.model.dao.entity;

import jakarta.persistence.*;
import lombok.*;
import org.checkerframework.checker.units.qual.C;

import java.time.LocalDateTime;

@Entity
@Table(name = "ranks")
@Builder
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
@ToString
public class Rank {

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

    @Column(name = "category_nm")
    private String categoryNm;

    @Column(name = "create_at")
    private LocalDateTime createAt;

    @Column(name = "update_at")
    private LocalDateTime updateAt;

    @ManyToOne
    @JoinColumn(name = "pill_id")
    private RankPill pill;

    @ManyToOne
    @JoinColumn(name = "mid_category_id")
    private RankMidCategory midCategory;
}
