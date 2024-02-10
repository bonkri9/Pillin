package com.ssafy.yourpiliing.presentation.viewmodel

import android.content.SharedPreferences
import androidx.lifecycle.ViewModel
import com.ssafy.yourpiliing.presentation.retrofit.RestClient
import com.ssafy.yourpiliing.presentation.retrofit.login.LoginState
import com.ssafy.yourpilling.presentation.retrofit.login.LoginRequest
import com.ssafy.yourpilling.presentation.retrofit.login.LoginService
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class LoginViewModel : ViewModel() {
    private val _loginState = MutableStateFlow<LoginState>(LoginState.Loading)
    val loginState: StateFlow<LoginState> = _loginState

    fun login(request: LoginRequest, sharedPreferences: SharedPreferences) {
        val loginService = RestClient.request().create(LoginService::class.java)

        loginService.login(request).enqueue(object : Callback<Unit> {
            override fun onResponse(call: Call<Unit>, response: Response<Unit>) {
                if (response.isSuccessful) {
                    // 로그인 성공 처리
                    val accessToken: String = response.headers()["accessToken"]!!

                    sharedPreferences.edit()
                        .putString("accessToken", accessToken)
                        .apply()
                    RestClient.setAccessToken(accessToken)

                    _loginState.value = LoginState.Success
                } else {
                    _loginState.value = LoginState.Failure("아이디 혹은 비밀번호가 일치하지 않습니다.")
                }
            }

            override fun onFailure(call: Call<Unit>, t: Throwable) {
                _loginState.value = LoginState.Failure("네트워크 혹은 시스템에 문제가 발생해 로그인 할 수 없습니다.")
            }
        })
    }
}