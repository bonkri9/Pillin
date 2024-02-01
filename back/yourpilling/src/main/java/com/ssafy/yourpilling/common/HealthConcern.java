package com.ssafy.yourpilling.common;

import lombok.Getter;

@Getter
public enum HealthConcern {
    DENTAL_BONE_HEALTH(0, "Dental/Bone Health", "치아/뼈 건강"),
    CHILDREN(1, "Children", "어린이"),
    WOMEN_HEALTH(2, "Women's Health", "여성 건강"),
    MEN_HEALTH(3, "Men's Health", "남성 건강"),
    DIGESTIVE_URINARY(4, "Digestive/Urinary", "위장/배뇨"),
    FATIGUE_LIVER(5, "Fatigue/Liver", "피로/간"),
    SKIN_HEALTH(6, "Skin Health", "피부 건강"),
    MEMORY_IMPROVEMENT(7, "Memory Improvement", "기억력 개선"),
    EYE_HEALTH(8, "Eye Health", "눈 건강"),
    BLOOD_PRESSURE_SUGAR_CIRCULATION(9, "Blood Pressure, Sugar, Circulation", "혈압, 혈당, 혈행"),
    DIET(10, "Diet", "다이어트"),
    PREGNANT_WOMEN(11, "Pregnant Women", "임산부"),
    STRESS_SLEEP(12, "Stress/Sleep", "스트레스/수면"),
    IMMUNE_ANTIOXIDANT(13, "Immune/Antioxidant", "면역/항산화"),
    HAIR_LOSS(14, "Hair Loss", "탈모");

    private final int index;
    private final String english;
    private final String korean;

    HealthConcern(int index, String english, String korean) {
        this.index = index;
        this.english = english;
        this.korean = korean;
    }
}