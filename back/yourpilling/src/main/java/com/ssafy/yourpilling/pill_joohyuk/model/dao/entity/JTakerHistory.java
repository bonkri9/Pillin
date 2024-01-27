package com.ssafy.yourpilling.pill_joohyuk.model.dao.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;

@Entity
@Table(name = "TakerHistory")
@Builder
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class JTakerHistory {

    @Id
    @Column(name = "take_record_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(name = "take_at")
    private LocalDate takeAt;

    @Column(name = "need_to_take_count")
    private Integer needToTakeCount;

    @Column(name = "current_take_count")
    private Integer currentTakeCount;

    @Column(name = "created_at")
    private LocalDate createdAt;

    @Column(name = "updated_at")
    private LocalDate updatedAt;

    @ManyToOne
    @JoinColumn(name = "own_pill_id") // 외래키 컬럼 이름
    private JOwnPill ownPill;
}
