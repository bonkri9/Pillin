package com.ssafy.yourpiliing.presentation.retrofit.weekly

import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface WeeklyService {

    @GET("/api/v1/pill/history/weekly")
    fun weekly() : Call<WeeklyResponse>
}