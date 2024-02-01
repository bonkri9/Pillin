package com.ssafy.yourpilling.rank.model.dao.entity;

import com.ssafy.yourpilling.pill.model.dao.entity.BigCategory;
import com.ssafy.yourpilling.pill.model.dao.entity.PillCategory;
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
@ToString
public class RankMidCategory {

    @Id
    @Column(name = "mid_category_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long midCategoryId;

    @Column(name = "category_nm")
    private String categoryNm;

}
