package com.ssafy.yourpilling.takerhistory.model.dao.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "takerhistory")
@Builder
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class TakerHistoryTakerHistory {

    @Id
    @Column(name="take_record_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long takerHistoryId;

    @Column(name = "take_at")
    private LocalDate takeAt;

    @Column(name = "need_to_take_count")
    private Integer needToTakeCount;

    @Column(name = "current_take_count")
    private Integer currentTakeCount;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @ManyToOne
    @JoinColumn(name="own_pill_id")
    private TakerHistoryOwnPill ownPill;
}
