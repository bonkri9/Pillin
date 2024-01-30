package com.ssafy.yourpilling.common;

public enum Nutrient {
    VITAMINA("VitaminA", "비타민A"),
    VITAMINB2("VitaminB2", "비타민B2"),
    VITAMINB6("VitaminB6", "비타민B6"),
    VITAMINB12("VitaminB12", "비타민B12"),
    VITAMINC("VitaminC", "비타민C"),
    VITAMIND("VitaminD", "비타민D"),
    VITAMINE("VitaminE", "비타민E"),
    VITAMINK("VitaminK", "비타민K"),
    CALCIUM("Calcium", "칼슘"),
    POTASSIUM("Potassium", "칼륨"),
    MAGNESIUM("Magnesium", "마그네슘"),
    MANGANESE("Manganese", "망간"),
    SELENIUM("Selenium", "셀레늄"),
    FOLIC_ACID("FolicAcid", "엽산"),
    AMINO_ACID("AminoAcid", "아미노산"),
    PANTOTHENIC_ACID("PantothenicAcid", "판토텐산"),
    BIOTIN("Biotin", "비오틴"),
    STEEL("Steel", "철"),
    OMEGA3("Omega3", "오메가3");

    private final String english;
    private final String korean;

    Nutrient(String english, String korean) {
        this.english = english;
        this.korean = korean;
    }

    public String getEnglish() {
        return english;
    }

    public String getKorean() {
        return korean;
    }
}