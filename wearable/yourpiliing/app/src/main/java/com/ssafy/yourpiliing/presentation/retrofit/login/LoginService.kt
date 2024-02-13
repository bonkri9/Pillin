package com.ssafy.yourpilling.presentation.retrofit.login

import retrofit2.Call
import retrofit2.http.Body
import retrofit2.http.POST

interface LoginService{

    @POST("/api/v1/login")
    fun login(@Body request: LoginRequest): Call<Unit>
}
