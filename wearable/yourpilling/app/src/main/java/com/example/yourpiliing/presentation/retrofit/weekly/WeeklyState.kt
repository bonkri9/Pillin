package com.example.yourpilling.presentation.retrofit.weekly

sealed class WeeklyState {
    object Loading : WeeklyState()
    data class Success(val response: MutableList<WeeklyResponseItem>) : WeeklyState()
    data class Failure(val message: String) : WeeklyState()
}