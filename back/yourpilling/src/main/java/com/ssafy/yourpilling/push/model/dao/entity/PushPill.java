package com.ssafy.yourpilling.push.model.dao.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Table(name = "pill")
@Builder
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class PushPill {

    @Id
    @Column(name = "pill_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long pillId;

    @Column
    private String name;


}
