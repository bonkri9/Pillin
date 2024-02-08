package com.ssafy.yourpiliing.presentation.viewmodel

import android.content.SharedPreferences
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.ssafy.yourpiliing.presentation.retrofit.TokenInterceptor
import com.ssafy.yourpiliing.presentation.retrofit.analysis.AnalysisResponse
import com.ssafy.yourpiliing.presentation.retrofit.analysis.AnalysisService
import com.ssafy.yourpiliing.presentation.retrofit.analysis.AnalysisState
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import okhttp3.OkHttpClient
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class AnalysisViewModel : ViewModel() {
    private val _analysisState = MutableStateFlow<AnalysisState>(AnalysisState.Loading)
    val analysisState: StateFlow<AnalysisState> = _analysisState;

    fun analysis(sharedPreferences: SharedPreferences) {
        val accessToken = sharedPreferences.getString("accessToken", null);

        if (accessToken == null) return

        val analysisService = request(accessToken).create(AnalysisService::class.java)

        analysisService.analysis(2103).enqueue(object : Callback<AnalysisResponse> {
            override fun onResponse(
                call: Call<AnalysisResponse>,
                response: Response<AnalysisResponse>
            ) {
                if (response.isSuccessful) {
                    if(response.body() != null){
                        _analysisState.value = AnalysisState.Success(response.body()!!)
                    }
                } else {
                    //_analysisState.value = AnalysisState.Failure("분석 정보를 가져오지 못했습니다.")
                }
            }

            override fun onFailure(call: Call<AnalysisResponse>, t: Throwable) {
//                _analysisState.value =
//                    AnalysisState.Failure("네트워크 혹은 시스템에 문제가 발생해 분석 정보를 가져오지 못했습니다.")
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