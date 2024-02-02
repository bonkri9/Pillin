package com.ssafy.yourpilling.common;

import lombok.Getter;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Arrays;

@Getter
public enum AgeGroup {
    UNDER_TEN(0, 9, "10대 이전"),
    TEN(10, 19, "10대"),
    TWENTY(21, 29, "20대"),
    THIRTY(31, 39, "30대"),
    FORTY(41, 49, "40대"),
    FIFTY(51, 59, "50대"),
    SIXTY(61, 69, "60대"),
    SEVENTY(71, 200, "70대 이후");


    private final int startAge;
    private final int endAge;
    private final String range;

    AgeGroup(int startAge, int endAge, String range) {
        this.startAge = startAge;
        this.endAge = endAge;
        this.range = range;
    }

    public static AgeGroup whatAgeGroup(LocalDateTime birthday){
        int birthYear = Math.abs(LocalDate.now().getYear() - birthday.getYear());

        return Arrays.stream(AgeGroup.values())
                .filter(a -> a.startAge <= birthYear && birthYear <= a.endAge)
                .findAny()
                .orElseThrow(() -> new IllegalArgumentException("알맞은 나잇대를 찾을 수 없습니다."));
    }
}
