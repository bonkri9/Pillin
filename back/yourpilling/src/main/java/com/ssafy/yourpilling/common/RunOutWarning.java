package com.ssafy.yourpilling.common;

import lombok.Getter;

import java.util.Arrays;

@Getter
public enum RunOutWarning {

    DANGER("danger", -1, 20),
    WARNING("warning", 20, 40),
    ENOUGH("enough", 40, 100);

    private final String message;
    private final double limitLowPercent;
    private final double limitHighPercent;


    RunOutWarning(String message, double limitLowPercent, double limitHighPercent) {
        this.message = message;
        this.limitLowPercent = limitLowPercent;
        this.limitHighPercent = limitHighPercent;
    }

    public static String getMessage(double percent){
        return Arrays.stream(RunOutWarning.values())
                .filter(w -> (w.getLimitLowPercent() < percent) && (percent <= w.getLimitHighPercent()))
                .findAny()
                .orElseThrow(() -> new IllegalArgumentException("재고 경고 계산 중 에러가 발생했습니다."))
                .getMessage();
    }
}
