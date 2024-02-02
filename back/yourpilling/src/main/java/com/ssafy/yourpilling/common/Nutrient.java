package com.ssafy.yourpilling.common;

import lombok.Getter;

import java.util.List;

@Getter
public enum Nutrient {
    VITAMINA("VitaminA", "비타민A", List.of(1, 8, 13)),
    VITAMINB1("VitaminB1", "비타민B1", List.of(10)),
    VITAMINB2("VitaminB2", "비타민B2", List.of(1, 2, 3, 5, 6)),
    VITAMINB3("VitaminB3", "비타민B3", List.of(5)),
    VITAMINB6("VitaminB6", "비타민B6", List.of(2, 5, 6, 12)),
    VITAMINB12("VitaminB12", "비타민B12", List.of(2, 3, 4, 7, 9, 11, 12)),
    VITAMINC("VitaminC", "비타민C", List.of(0, 2, 6, 9, 10, 13)),
    VITAMIND("VitaminD", "비타민D", List.of(0, 6, 13)),
    VITAMINE("VitaminE", "비타민E", List.of(13)),
    VITAMINK("VitaminK", "비타민K", List.of(0, 9, 13)),
    CALCIUM("Calcium", "칼슘", List.of(0, 1, 9, 10, 11)),
    POTASSIUM("Potassium", "칼륨", List.of(0, 9, 10)),
    MAGNESIUM("Magnesium", "마그네슘", List.of(0, 9)),
    MANGANESE("Manganese", "망간", List.of(0, 1, 6, 9, 12, 13)),
    SELENIUM("Selenium", "셀레늄", List.of(0, 3, 5, 9, 12, 13)),
    FOLIC_ACID("FolicAcid", "엽산", List.of(1, 2, 5, 9, 11, 12)),
    AMINO_ACID("AminoAcid", "아미노산", List.of(1, 2, 3, 5, 6, 9, 10, 11, 13)),
    PANTOTHENIC_ACID("PantothenicAcid", "판토텐산", List.of(4, 5, 6, 10, 12)),
    BIOTIN("Biotin", "비오틴", List.of(5, 6, 12, 13)),
    IRON("Iron", "철분", List.of(2, 7, 11)),
    OMEGA3("Omega3", "오메가3", List.of(2, 8, 9)),
    CHROMIUM("Chromium", "크롬", List.of(9));

    private final String english;
    private final String korean;

    private final List<Integer> healthConcernIndex;

    Nutrient(String english, String korean, List<Integer> healthConcernIndex) {
        this.english = english;
        this.korean = korean;
        this.healthConcernIndex = healthConcernIndex;
    }
}