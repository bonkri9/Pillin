package com.ssafy.yourpilling.presentation.retrofit.analysis

import kotlinx.coroutines.Deferred
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface AnalysisService {

    @GET("/api/v1/pill/analysis")
    fun analysis() : Call<AnalysisResponse>
}