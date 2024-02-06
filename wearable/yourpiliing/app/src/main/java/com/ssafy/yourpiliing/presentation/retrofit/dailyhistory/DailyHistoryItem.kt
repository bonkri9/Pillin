package com.ssafy.yourpiliing.presentation.retrofit.dailyhistory

data class DailyHistoryItem(
    val ownPillId: Long,
    val name: String,
    val actualTakeCount: Int,
    val needToTakeTotalCount: Int,
    val takeYn: Boolean
)
