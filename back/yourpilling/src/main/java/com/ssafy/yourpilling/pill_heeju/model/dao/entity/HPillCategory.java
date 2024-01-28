package com.ssafy.yourpilling.pill_heeju.model.dao.entity;


import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "pillcategory")
@Builder
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class HPillCategory {


    @Id
    @Column(name = "mapping_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long mappingId;

    @ManyToOne
    @JoinColumn(name = "pill_id")
    private PillDetail pillDetail;

    @ManyToOne
    @JoinColumn(name = "mid_category_id")
    private HMidCategory midCategory;
}
