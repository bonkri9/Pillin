package com.ssafy.yourpilling.presentation.retrofit.dailyhistory

data class DailyHistoryItem(
    val ownPillId: Long,
    val name: String,
    val actualTakeCount: Int,
    val needToTakeTotalCount: Int,
    val takeCount: Int,
    val takeYn: Boolean
)
