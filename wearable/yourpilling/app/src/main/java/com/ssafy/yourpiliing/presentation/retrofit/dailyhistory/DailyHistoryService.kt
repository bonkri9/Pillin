package com.ssafy.yourpilling.presentation.retrofit.dailyhistory

import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface DailyHistoryService {

    @GET("/api/v1/pill/history/daily")
    fun daily(
        @Query("year") year: Int,
        @Query("month") month: Int,
        @Query("day") day: Int
    ): Call<DailyHistoryResponse>
}