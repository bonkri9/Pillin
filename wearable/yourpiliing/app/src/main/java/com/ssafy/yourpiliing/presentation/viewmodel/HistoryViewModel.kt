package com.ssafy.yourpiliing.presentation.viewmodel

import android.content.SharedPreferences
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.ssafy.yourpiliing.presentation.retrofit.TokenInterceptor
import com.ssafy.yourpiliing.presentation.retrofit.dailyhistory.DailyHistoryResponse
import com.ssafy.yourpiliing.presentation.retrofit.dailyhistory.DailyHistoryService
import com.ssafy.yourpiliing.presentation.retrofit.dailyhistory.DailyHistoryState
import okhttp3.OkHttpClient
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.Calendar

class HistoryViewModel : ViewModel() {

    private val _dailyHistoryState = MutableLiveData<DailyHistoryState>()
    val dailyHistoryResponse: LiveData<DailyHistoryState> = _dailyHistoryState

    fun dailyHistory(sharedPreferences: SharedPreferences){
        val accessToken = sharedPreferences.getString("accessToken", null);

        if(accessToken == null) return;

        val historyService = request(accessToken).create(DailyHistoryService::class.java)

        val calendar = Calendar.getInstance()
        val year = calendar.get(Calendar.YEAR)
        val month = calendar.get(Calendar.MONTH) + 1 // 0부터 시작하기 때문에 1 더합니다
        val day = calendar.get(Calendar.DAY_OF_MONTH)

        historyService.daily(year = year, month = month, day = day).enqueue(object : Callback<DailyHistoryResponse>{
            override fun onResponse(call: Call<DailyHistoryResponse>,
                                    response: Response<DailyHistoryResponse>) {
                if(response.isSuccessful){
                    if(response.body() != null){
                        _dailyHistoryState.value = DailyHistoryState.Success(response.body()!!)
                    }
                }else{
                    _dailyHistoryState.value = DailyHistoryState.Failure("데이터를 가져오는데 실패했습니다.")
                }
            }

            override fun onFailure(call: Call<DailyHistoryResponse>, t: Throwable) {
                _dailyHistoryState.value = DailyHistoryState.Failure("데이터를 가져오는데 실패했습니다.")
            }
        })
    }

    private fun request(accessToken : String) : Retrofit{
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