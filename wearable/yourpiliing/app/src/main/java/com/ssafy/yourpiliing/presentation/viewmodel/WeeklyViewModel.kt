package com.ssafy.yourpiliing.presentation.viewmodel

import android.content.SharedPreferences
import androidx.lifecycle.ViewModel
import com.ssafy.yourpiliing.presentation.retrofit.RestClient
import com.ssafy.yourpiliing.presentation.retrofit.weekly.WeeklyResponse
import com.ssafy.yourpiliing.presentation.retrofit.weekly.WeeklyResponseItem
import com.ssafy.yourpiliing.presentation.retrofit.weekly.WeeklyService
import com.ssafy.yourpiliing.presentation.retrofit.weekly.WeeklyState
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import java.time.DayOfWeek
import java.time.LocalDate
import java.time.temporal.TemporalAdjusters

class WeeklyViewModel : ViewModel() {
    private val _weeklySate = MutableStateFlow<WeeklyState>(WeeklyState.Loading)
    val weeklyState: StateFlow<WeeklyState> = _weeklySate

    fun weekly(sharedPreferences: SharedPreferences) {
        val accessToken = sharedPreferences.getString("accessToken", null);

        if (accessToken == null) return

        val weeklyService = RestClient.request().create(WeeklyService::class.java)

        weeklyService.weekly().enqueue(object : Callback<WeeklyResponse> {
            override fun onResponse(
                call: Call<WeeklyResponse>,
                response: Response<WeeklyResponse>
            ) {
                if (response.isSuccessful) {
                    if(response.body() != null){
                        val body = response.body()!!.data
                        addEmptyDate(body)
                        _weeklySate.value = WeeklyState.Success(body)
                    }
                } else {
                    _weeklySate.value = WeeklyState.Failure("주간 기록을 가져오지 못했습니다! 다시 시도해 주세요.");
                }
            }

            override fun onFailure(call: Call<WeeklyResponse>, t: Throwable) {
                _weeklySate.value = WeeklyState.Failure("네트워크 혹은 시스템에 문제가 발생해 주간 기록을 가져오지 못했습니다");
            }
        })
    }

    // 이번주의 날 중 포함되어 있지 않으면 추가
    private fun addEmptyDate(body : MutableList<WeeklyResponseItem>){
        // 주의 시작일 계산
        val startOfWeek = LocalDate.now().with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY))
        // 주의 종료일 계산
        val endOfWeek = startOfWeek.plusDays(6)

        var day = startOfWeek
        while (day.isBefore(endOfWeek) || day.isEqual(endOfWeek)) {
            val dayString = day.toString()

            val isContainDate = body.any { it.date == dayString }
            if(!isContainDate){
                body.add(WeeklyResponseItem(dayString, 0, 0))
            }

            day = day.plusDays(1)
        }

        body.sortBy { it.date }
    }
}