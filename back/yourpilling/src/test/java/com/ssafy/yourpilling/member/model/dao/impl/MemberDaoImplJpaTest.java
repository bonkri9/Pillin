package com.ssafy.yourpilling.member.model.dao.impl;

import com.ssafy.yourpilling.common.Gender;
import com.ssafy.yourpilling.member.model.dao.MemberDao;
import com.ssafy.yourpilling.member.model.dao.entity.MemberProfile;
import com.ssafy.yourpilling.member.model.dao.jpa.MemberJpaRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

import static java.time.LocalDate.now;
import static org.junit.jupiter.api.Assertions.assertFalse;

@SpringBootTest
@Transactional
@DisplayName("member dao 테스트")
class MemberDaoImplJpaTest {

    @Autowired
    private MemberDao memberDao;

    @Autowired
    private MemberJpaRepository memberJpaRepository;

    @Autowired
    private BCryptPasswordEncoder encoder;

    @Test
    public void register() {
        // given
        MemberProfile memberProfile = MemberProfile
                .builder()
                .username("test@test.com")
                .password(encoder.encode("1234"))
                .name("kkk")
                .nickname("ksb")
                .birth(now())
                .gender(Gender.MAN)
                .createdAt(LocalDateTime.now())
                .build();

        // when
        memberDao.register(memberProfile);

        // then
        assertFalse(memberJpaRepository.findByUsername(memberProfile.getUsername()).isEmpty());
    }
}