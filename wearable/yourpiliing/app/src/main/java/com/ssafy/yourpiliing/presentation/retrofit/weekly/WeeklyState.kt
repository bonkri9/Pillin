package com.ssafy.yourpiliing.presentation.retrofit.weekly

sealed class WeeklyState {
    object Loading : WeeklyState()
    data class Success(val response : WeeklyResponse) : WeeklyState()
    data class Failure(val message: String) : WeeklyState()
}