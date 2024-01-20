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
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 30)
    private String username;

    @Column(nullable = false, length = 100)
    private String password;

    @Column(nullable = false, length = 100)
    private String nickname;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 10)
    private Role role;
}
