package com.ssafy.yourpilling.member.model.dao.entity;

import com.ssafy.yourpilling.common.Gender;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "members")
@Builder
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class MemberProfile {

    @Id
    @Column(name = "member_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long memberId;

    @Column
    private String username;

    @Column
    private String password;

    @Column
    private String name;

    @Column
    private String nickname;

    @Column
    private LocalDate birth;

    @Column
    @Enumerated(EnumType.STRING)
    private Gender gender;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

}