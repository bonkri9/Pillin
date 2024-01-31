package com.ssafy.yourpilling.member.model.service.vo.out;

import com.ssafy.yourpilling.common.Gender;
import com.ssafy.yourpilling.common.Role;
import lombok.Builder;
import lombok.Value;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Value
@Builder
public class OutMemberVo {

    String email;
    String name;
    String nickname;
    LocalDate birthday;
    Gender gender;
    String providerId;
    LocalDateTime createAt;
    LocalDateTime updateAt;
    Role role;
}
