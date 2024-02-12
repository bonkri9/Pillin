package com.ssafy.yourpilling.presentation.retrofit.fcm

import retrofit2.Call
import retrofit2.http.Body
import retrofit2.http.POST

interface FcmService {

    @POST("/api/v1/push/device-token")
    fun register(@Body fcmRequest: FcmRequest): Call<Unit>
}