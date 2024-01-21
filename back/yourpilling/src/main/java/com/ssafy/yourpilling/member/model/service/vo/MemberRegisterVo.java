package com.ssafy.yourpilling.member.model.service.vo;

import com.ssafy.yourpilling.common.Gender;
import lombok.Builder;
import lombok.Value;

import java.time.LocalDate;

@Value
@Builder
public class MemberRegisterVo {
    String email;
    String password;
    LocalDate birthday;
    String nickname;
    String name;
    Gender gender;
}
