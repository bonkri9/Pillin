package com.ssafy.yourpilling.security.auth.entity;

import com.ssafy.yourpilling.common.Role;
import jakarta.persistence.*;
import lombok.*;


@Entity
@Table(name = "members")
@Builder
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class Member {

    @Id
    private Long memberId;

    @Column(unique = true, nullable = false)
    private String username;

    @Column
    private String password;

    @Column
    private String nickname;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 10)
    private Role role;
}
