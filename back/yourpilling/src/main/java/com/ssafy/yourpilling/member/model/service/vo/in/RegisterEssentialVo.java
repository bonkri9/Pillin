package com.ssafy.yourpilling.member.model.service.vo.in;

import com.ssafy.yourpilling.common.Gender;
import lombok.Builder;
import lombok.Value;

import java.time.LocalDate;

@Value
@Builder
public class RegisterEssentialVo {
    Long memberId;
    LocalDate birthday;
    Gender gender;
}
