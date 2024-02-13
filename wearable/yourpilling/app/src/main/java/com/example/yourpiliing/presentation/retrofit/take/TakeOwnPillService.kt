package com.example.yourpilling.presentation.retrofit.take

import retrofit2.Call
import retrofit2.http.Body
import retrofit2.http.PUT

interface TakeOwnPillService {

    @PUT("/api/v1/pill/take")
    fun take(@Body request: TakeOwnPillRequest): Call<Unit>
}