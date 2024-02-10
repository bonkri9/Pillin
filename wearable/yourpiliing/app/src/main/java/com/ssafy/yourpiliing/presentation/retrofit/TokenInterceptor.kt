package com.ssafy.yourpiliing.presentation.retrofit

import okhttp3.Interceptor
import okhttp3.Response

class TokenInterceptor(private val accessToken: String) : Interceptor {
    override fun intercept(chain: Interceptor.Chain): Response {
        val request = chain.request().newBuilder()
            .addHeader("accessToken", accessToken)
            .build()
        return chain.proceed(request);
    }
}