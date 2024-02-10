package com.ssafy.yourpiliing.presentation.viewmodel

import android.content.SharedPreferences
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.ssafy.yourpiliing.presentation.retrofit.RestClient
import com.ssafy.yourpiliing.presentation.retrofit.dailyhistory.DailyHistoryResponse
import com.ssafy.yourpiliing.presentation.retrofit.dailyhistory.DailyHistoryService
import com.ssafy.yourpiliing.presentation.retrofit.dailyhistory.DailyHistoryState
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import java.util.Calendar

class HistoryViewModel : ViewModel() {

    private val _dailyHistoryState = MutableLiveData<DailyHistoryState>()
    val dailyHistoryState: LiveData<DailyHistoryState> = _dailyHistoryState

    fun dailyHistory(sharedPreferences: SharedPreferences) {
        val accessToken = sharedPreferences.getString("accessToken", null);

        if (accessToken == null) return;

        val historyService = RestClient.request().create(DailyHistoryService::class.java)

        val calendar = Calendar.getInstance()
        val year = calendar.get(Calendar.YEAR)
        val month = calendar.get(Calendar.MONTH) + 1 // 0부터 시작하기 때문에 1 더함
        val day = calendar.get(Calendar.DAY_OF_MONTH)

        historyService.daily(year = year, month = month, day = day)
            .enqueue(object : Callback<DailyHistoryResponse> {
                override fun onResponse(
                    call: Call<DailyHistoryResponse>,
                    response: Response<DailyHistoryResponse>
                ) {
                    if (response.isSuccessful) {
                        if (response.body() != null) {
                            _dailyHistoryState.value = DailyHistoryState.Success(response.body()!!)
                        }
                    } else {
                        _dailyHistoryState.value = DailyHistoryState.Failure("데이터를 가져오는데 실패했습니다.")
                    }
                }

                override fun onFailure(call: Call<DailyHistoryResponse>, t: Throwable) {
                    _dailyHistoryState.value =
                        DailyHistoryState.Failure("네트워크 혹은 시스템에 문제가 발생해 데이터를 가져올 수 없습니다.")
                }
            })
    }

    fun resetState(){
        _dailyHistoryState.value = DailyHistoryState.Loading
    }
}