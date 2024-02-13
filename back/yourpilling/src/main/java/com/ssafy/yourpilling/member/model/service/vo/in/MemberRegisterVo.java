package com.ssafy.yourpilling.member.model.service.vo.in;

import com.ssafy.yourpilling.common.Gender;
import lombok.Builder;
import lombok.Value;

import java.time.LocalDate;

@Value
@Builder
public class MemberRegisterVo {
    String email;
    String password;
    String name;
}
