package com.ssafy.yourpilling.security.auth.model.service.vo.in.value;

import com.ssafy.yourpilling.common.Role;
import lombok.Builder;
import lombok.Value;

import java.time.LocalDateTime;

@Value
@Builder
public class KakaoValue {
    String providerId;
    String username;
    String name;
    LocalDateTime createAt;
    Role role;
}
