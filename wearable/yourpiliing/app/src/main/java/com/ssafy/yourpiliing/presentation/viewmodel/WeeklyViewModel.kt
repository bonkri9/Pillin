package com.ssafy.yourpiliing.presentation.viewmodel

import android.content.SharedPreferences
import androidx.lifecycle.ViewModel
import com.ssafy.yourpiliing.presentation.retrofit.TokenInterceptor
import com.ssafy.yourpiliing.presentation.retrofit.weekly.WeeklyResponse
import com.ssafy.yourpiliing.presentation.retrofit.weekly.WeeklyService
import com.ssafy.yourpiliing.presentation.retrofit.weekly.WeeklyState
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import okhttp3.OkHttpClient
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class WeeklyViewModel : ViewModel() {
    private val _weeklySate = MutableStateFlow<WeeklyState>(WeeklyState.Loading)
    val weeklyState : StateFlow<WeeklyState> = _weeklySate

    fun weekly(sharedPreferences: SharedPreferences){
        val accessToken = sharedPreferences.getString("accessToken", null);

        if (accessToken == null) return

        val weeklyService = request(accessToken).create(WeeklyService::class.java)

        weeklyService.weekly().enqueue(object : Callback<WeeklyResponse>{
            override fun onResponse(
                call: Call<WeeklyResponse>,
                response: Response<WeeklyResponse>
            ) {
                if (response.isSuccessful) {
                    _weeklySate.value = WeeklyState.Success(response.body()!!);
                } else {
                    _weeklySate.value = WeeklyState.Failure("주간 기록을 가져오지 못했습니다! 다시 시도해 주세요.");
                }
            }

            override fun onFailure(call: Call<WeeklyResponse>, t: Throwable) {
                _weeklySate.value = WeeklyState.Failure("네트워크 혹은 시스템에 문제가 발생해 주간 기록을 가져오지 못했습니다");
            }
        })
    }

    private fun request(accessToken: String): Retrofit {
        val httpClient = OkHttpClient.Builder()
            .addInterceptor(TokenInterceptor(accessToken))
            .build()

        return Retrofit
            .Builder()
            .baseUrl("https://i10b101.p.ssafy.io/")
            .addConverterFactory(GsonConverterFactory.create())
            .client(httpClient)
            .build()
    }
}