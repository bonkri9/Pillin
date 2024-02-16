package com.example.yourpilling.presentation.retrofit.weekly

data class WeeklyResponseItem(
    val date: String,
    val needToTakenCountToday: Int,
    val actualTakenToday: Int
)