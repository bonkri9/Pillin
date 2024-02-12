package com.ssafy.yourpilling.presentation.retrofit.analysis

data class AnalysisResponse(
    val essentialNutrientsDataList: List<EssentialNutrientsData>
)

data class ExtractionAnalysisResponse(
    val essentialNutrientsDataList: List<EssentialNutrientsData>
) {
    val nutrients = mutableListOf<String>()
    val userTakes = mutableListOf<Double>()
    val excessiveTakes = mutableListOf<Double>()
    val recommendedIntakes = mutableListOf<Double>()
    val intakeDiagnosis = mutableListOf<String>()
    val units = mutableListOf<String>()

    init {
        essentialNutrientsDataList.forEach { datas ->
            nutrients.add(datas.nutrientsName)
            userTakes.add(datas.data.userIntake)
            excessiveTakes.add(datas.data.excessiveIntake)
            recommendedIntakes.add(datas.data.recommendedIntake)
            intakeDiagnosis.add(datas.data.intakeDiagnosis)
            units.add(datas.data.unit)
        }
    }
}