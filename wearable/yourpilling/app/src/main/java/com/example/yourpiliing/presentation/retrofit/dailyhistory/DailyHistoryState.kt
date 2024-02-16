package com.example.yourpilling.presentation.retrofit.dailyhistory

sealed class DailyHistoryState {
    object Loading : DailyHistoryState()
    data class Success(val response: DailyHistoryResponse) : DailyHistoryState()
    data class Failure(val message: String) : DailyHistoryState()
}