package com.ssafy.yourpiliing.presentation.retrofit.fcm

import java.util.Objects

sealed class FcmStatus {
    object Loading : FcmStatus()
    object Success : FcmStatus()
    object Failure : FcmStatus()
}
