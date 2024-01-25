package com.ssafy.yourpilling.common;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;
import lombok.Getter;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Getter
public enum TakeWeekday {
    MON("MON", 0),
    TUE("TUE", 1),
    WED("WED", 2),
    THU("THU", 3),
    FRI("FRI", 4),
    SAT("SAT", 5),
    SUN("SUN", 6);

    private final String day;
    private final Integer value;

    TakeWeekday(String day, Integer value){
        this.day = day;
        this.value = value;
    }
    @JsonValue
    public String getDay() {
        return day;
    }

    @JsonCreator
    public static TakeWeekday fromString(String val) {
        return Arrays.stream(TakeWeekday.values())
                .filter(t -> t.getDay().equalsIgnoreCase(val))
                .findAny()
                .orElseThrow(() -> new IllegalArgumentException("알맞은 요일 형식이 아닙니다. " + val));
    }

    public static List<String> toTakeWeekdays(Integer val){
        List<String> takeWeekdays = new ArrayList<>();

        for(int i=0; i<TakeWeekday.values().length; i++){
            if((val & (1<<i)) == 0) continue;

            takeWeekdays.add(TakeWeekday.values()[i].getDay());
        }
        return takeWeekdays;
    }

    public static Integer toValue(List<TakeWeekday> takeWeekdays){
        int val = 0;

        for (TakeWeekday take : takeWeekdays) {
            int bit = Arrays.stream(TakeWeekday.values())
                    .filter(t -> t.getDay().equalsIgnoreCase(take.getDay()))
                    .findAny()
                    .orElseThrow(() -> new IllegalArgumentException("알맞은 요일 형식이 아닙니다. " + take.getDay()))
                    .getValue();

            val ^= (1 << bit);
        }
        return val;
    }

}
