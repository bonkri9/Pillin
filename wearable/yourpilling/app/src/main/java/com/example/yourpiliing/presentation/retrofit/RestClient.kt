package com.example.yourpilling.presentation.retrofit

import okhttp3.OkHttpClient
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

object RestClient {
    private var retrofit: Retrofit? = null

    fun setAccessToken(token: String) {
        // 토큰 값이 변경되었을 때 Retrofit 인스턴스를 다시 생성
        val httpClient = OkHttpClient.Builder()
            .addInterceptor(TokenInterceptor(token))
            .build()

        retrofit = Retrofit.Builder()
            .baseUrl("https://i10b101.p.ssafy.io/")
            .addConverterFactory(GsonConverterFactory.create())
            .client(httpClient)
            .build()
    }

    fun request(): Retrofit {
        if (retrofit == null) {
            retrofit = Retrofit.Builder()
                .baseUrl("https://i10b101.p.ssafy.io/")
                .addConverterFactory(GsonConverterFactory.create())
                .build()
        }
        return retrofit!!
    }
}