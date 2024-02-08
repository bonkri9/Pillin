package com.ssafy.yourpiliing.presentation.retrofit.weekly

import java.time.LocalDate

data class WeeklyResponseItem (
    val date : LocalDate,
    val needToTakenCountToday : Int,
    val actualTakenToday : Int
)