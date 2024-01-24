package com.ssafy.yourpilling.pill.model.dao.entity;


import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "pillcategory")
@Builder
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class PillCategory {


    @Id
    @Column(name = "mapping_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long mappingId;

    @ManyToOne
    @JoinColumn(name = "pill_pill_id")
    private Pill pill;

    @ManyToOne
    @JoinColumn(name = "midcategory_mid_category_id")
    private MidCategory midCategory;
}
