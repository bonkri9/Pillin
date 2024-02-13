package com.example.yourpilling.presentation.viewmodel

import android.content.SharedPreferences
import androidx.lifecycle.ViewModel
import com.example.yourpilling.presentation.retrofit.RestClient
import com.example.yourpilling.presentation.retrofit.take.TakeOwnPillRequest
import com.example.yourpilling.presentation.retrofit.take.TakeOwnPillService
import com.example.yourpilling.presentation.retrofit.take.TakeOwnPillState
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class TakeOwnPillViewModel : ViewModel() {

    private val _takeOwnPillState = MutableStateFlow<TakeOwnPillState>(TakeOwnPillState.Loading)
    val takeOwnPillState: StateFlow<TakeOwnPillState> = _takeOwnPillState

    fun take(requestBody: TakeOwnPillRequest, sharedPreferences: SharedPreferences) {
        val accessToken = sharedPreferences.getString("accessToken", null);

        if (accessToken == null) return

        val takeOwnPillService = RestClient.request().create(TakeOwnPillService::class.java)

        takeOwnPillService.take(requestBody).enqueue(object : Callback<Unit> {
            override fun onResponse(
                call: Call<Unit>,
                response: Response<Unit>
            ) {
                if (response.isSuccessful) {
                    _takeOwnPillState.value = TakeOwnPillState.Success;
                } else {
                    _takeOwnPillState.value = TakeOwnPillState.Failure("복용에 실패했습니다! 다시 시도해 주세요.");
                }
            }

            override fun onFailure(call: Call<Unit>, t: Throwable) {
                _takeOwnPillState.value =
                    TakeOwnPillState.Failure("네트워크 혹은 시스템에 문제가 발생해 복용 기록에 실패했습니다.")
            }
        })
    }
}