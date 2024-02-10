package com.ssafy.yourpiliing.presentation.retrofit.take

sealed class TakeOwnPillState {
    object Loading : TakeOwnPillState()
    object Success : TakeOwnPillState()
    data class Failure(val message: String) : TakeOwnPillState()
}