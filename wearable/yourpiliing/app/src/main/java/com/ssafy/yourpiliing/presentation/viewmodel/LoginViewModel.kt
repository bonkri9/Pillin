package com.ssafy.yourpiliing.presentation.viewmodel

import android.content.SharedPreferences
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.ssafy.yourpiliing.presentation.retrofit.login.LoginState
import com.ssafy.yourpilling.presentation.retrofit.login.LoginRequest
import com.ssafy.yourpilling.presentation.retrofit.login.LoginService
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class LoginViewModel : ViewModel() {
    private val _loginState = MutableLiveData<LoginState>()
    val loginState: LiveData<LoginState> = _loginState

    fun login(request: LoginRequest, sharedPreferences: SharedPreferences) {
        val loginService = request().create(LoginService::class.java)

        loginService.login(request).enqueue(object : Callback<Unit> {
            override fun onResponse(call: Call<Unit>, response: Response<Unit>) {
                if(response.isSuccessful){
                    // 로그인 성공 처리
                    val accessToken:String? = response.headers()["accessToken"]

                    sharedPreferences.edit()
                        .putString("accessToken", accessToken)
                        .apply()
                    _loginState.value = LoginState.Success("성공")
                }else{
                    _loginState.value = LoginState.Failure("아이디 혹은 비밀번호가 일치하지 않습니다.")
                }
            }

            override fun onFailure(call: Call<Unit>, t: Throwable) {
                _loginState.value = LoginState.Failure("네트워크 혹은 시스템에 문제가 발생해 로그인 할 수 없습니다.")
            }
        })
    }

    private fun request() : Retrofit{
        return Retrofit
            .Builder()
            .baseUrl("https://i10b101.p.ssafy.io/")
            .addConverterFactory(GsonConverterFactory.create())
            .build()
    }
}