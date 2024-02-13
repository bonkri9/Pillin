package com.example.yourpilling.presentation.viewmodel

import android.content.SharedPreferences
import androidx.lifecycle.ViewModel
import com.example.yourpilling.presentation.retrofit.RestClient
import com.example.yourpilling.presentation.retrofit.analysis.AnalysisResponse
import com.example.yourpilling.presentation.retrofit.analysis.AnalysisService
import com.example.yourpilling.presentation.retrofit.analysis.AnalysisState
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class AnalysisViewModel : ViewModel() {
    private val _analysisState = MutableStateFlow<AnalysisState>(AnalysisState.Loading)
    val analysisState: StateFlow<AnalysisState> = _analysisState;

    fun analysis(sharedPreferences: SharedPreferences) {
        val accessToken = sharedPreferences.getString("accessToken", null);

        if (accessToken == null) return

        val analysisService = RestClient.request().create(AnalysisService::class.java)

        analysisService.analysis().enqueue(object : Callback<AnalysisResponse> {
            override fun onResponse(
                call: Call<AnalysisResponse>,
                response: Response<AnalysisResponse>
            ) {
                if (response.isSuccessful) {
                    if (response.body() != null) {
                        _analysisState.value = AnalysisState.Success(response.body()!!)
                    }
                } else {
                    _analysisState.value = AnalysisState.Failure("분석 정보를 가져오지 못했습니다.")
                }
            }

            override fun onFailure(call: Call<AnalysisResponse>, t: Throwable) {
                _analysisState.value =
                    AnalysisState.Failure("네트워크 혹은 시스템에 문제가 발생해 분석 정보를 가져오지 못했습니다.")
            }
        })
    }
}