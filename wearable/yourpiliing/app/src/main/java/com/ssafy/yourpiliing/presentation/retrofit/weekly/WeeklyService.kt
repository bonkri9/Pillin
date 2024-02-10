package com.ssafy.yourpiliing.presentation.retrofit.weekly

import retrofit2.Call
import retrofit2.http.GET

interface WeeklyService {

    @GET("/api/v1/pill/history/weekly")
    fun weekly(): Call<WeeklyResponse>
}