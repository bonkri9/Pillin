package com.ssafy.yourpilling.common;

import lombok.Getter;

import java.util.Arrays;
import java.util.NoSuchElementException;

@Getter
public enum Role {
    MEMBER("member"), ADMIN("admin");

    private final String role;

    Role(String value) {
        this.role = value;
    }

    public static Role findByRoleValue(String value) {
        return Arrays.stream(Role.values()).filter(r -> r.role.equals(value))
                .findFirst().orElseThrow(() -> new NoSuchElementException("잘못된 타입 입니다."));
    }
}
