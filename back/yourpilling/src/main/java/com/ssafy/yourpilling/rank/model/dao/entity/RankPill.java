package com.ssafy.yourpilling.rank.model.dao.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "pill")
@Builder
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
@ToString
public class RankPill {

    @Id
    @Column(name = "pill_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long pillId;

    @Column
    private String name;

    @Column
    private String manufacturer;

    @Column(name = "image_url")
    private String imageUrl;
}
