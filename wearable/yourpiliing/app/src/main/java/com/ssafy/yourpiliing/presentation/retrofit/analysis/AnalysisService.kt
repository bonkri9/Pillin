package com.ssafy.yourpiliing.presentation.retrofit.analysis

import kotlinx.coroutines.Deferred
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface AnalysisService {

    @GET("/api/v1/pill/analysis")
    fun analysis(@Query("id") id: Int) : Call<AnalysisResponse>
}