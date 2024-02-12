package com.ssafy.yourpilling.presentation.retrofit.login

sealed class LoginState {
    object Loading : LoginState()
    object Success : LoginState()
    data class Failure(val message: String) : LoginState()
}