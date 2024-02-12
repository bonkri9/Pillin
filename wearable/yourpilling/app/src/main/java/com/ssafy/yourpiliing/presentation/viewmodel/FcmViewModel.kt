package com.ssafy.yourpilling.presentation.viewmodel

import android.content.SharedPreferences
import androidx.lifecycle.ViewModel
import com.google.android.gms.tasks.OnCompleteListener
import com.google.firebase.messaging.FirebaseMessaging
import com.ssafy.yourpiliing.presentation.retrofit.fcm.FcmStatus
import com.ssafy.yourpilling.presentation.retrofit.fcm.FcmRequest
import com.ssafy.yourpilling.presentation.retrofit.fcm.FcmService
import com.ssafy.yourpilling.presentation.retrofit.RestClient
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class FcmViewModel: ViewModel() {

    private val _fcmStatus = MutableStateFlow<FcmStatus>(FcmStatus.Loading)
    val fcmStatus: StateFlow<FcmStatus> = _fcmStatus

    fun fcmRegister(sharedPreferences: SharedPreferences){
        val accessToken = sharedPreferences.getString("accessToken", null);

        if (accessToken == null) return;

        RestClient.setAccessToken(accessToken)

        FirebaseMessaging.getInstance().token.addOnCompleteListener(OnCompleteListener { task ->
            if(!task.isSuccessful){
                return@OnCompleteListener
            }

            val t = task.result as String
            val split = t.split(":")

            if(split.size < 2){
                return@OnCompleteListener
            }

            val fcmService = RestClient.request().create(FcmService::class.java)
            fcmService.register(FcmRequest(split[1])).enqueue(object : Callback<Unit> {
                override fun onResponse(call: Call<Unit>, response: Response<Unit>) {
                    if(response.isSuccessful) {
                        _fcmStatus.value = FcmStatus.Success
                    }else{
                        _fcmStatus.value = FcmStatus.Failure
                    }
                }

                override fun onFailure(call: Call<Unit>, t: Throwable) {
                    _fcmStatus.value = FcmStatus.Failure
                }
            })
        })
    }
}