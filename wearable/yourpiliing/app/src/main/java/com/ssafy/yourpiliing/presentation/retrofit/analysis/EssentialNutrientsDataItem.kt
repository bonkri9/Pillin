package com.ssafy.yourpiliing.presentation.retrofit.analysis

data class EssentialNutrientsDataItem(
    val recommendedIntake : Double,
    val excessiveIntake : Double,
    val userIntake : Double,
    val unit : String,
    val intakeDiagnosis : String
)
