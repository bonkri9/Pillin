package com.ssafy.yourpilling.common;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;

import java.util.Arrays;

public enum Gender {
    MAN("MAN"), WOMAN("WOMAN");

    private final String gender;

    Gender(String gender) {
        this.gender = gender;
    }

    @JsonValue
    public String getGender() {
        return gender;
    }

    @JsonCreator
    public static Gender fromString(String value) {
        return Arrays.stream(Gender.values())
                .filter(g -> g.getGender().equalsIgnoreCase(value))
                .findAny()
                .orElseThrow(() -> new IllegalArgumentException("알맞은 Gender가 아닙니다. " + value));
    }
}
