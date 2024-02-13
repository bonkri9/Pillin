package com.ssafy.yourpiliing.presentation.retrofit.login

sealed class LoginState {
    object Loading : LoginState()
    data class Success(val accessToken: String) : LoginState()
    data class Failure(val message: String) : LoginState()
}