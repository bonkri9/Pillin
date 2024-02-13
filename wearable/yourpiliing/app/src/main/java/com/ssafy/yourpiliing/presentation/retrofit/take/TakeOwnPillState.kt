package com.ssafy.yourpiliing.presentation.retrofit.take

import androidx.compose.runtime.Stable

@Stable
sealed class TakeOwnPillState {
    object Loading : TakeOwnPillState()
    object Success : TakeOwnPillState()
    data class Failure(val message: String) : TakeOwnPillState()
}