package com.example.yourpiliing.presentation.retrofit.fcm

sealed class FcmStatus {
    object Loading : FcmStatus()
    object Success : FcmStatus()
    object Failure : FcmStatus()
}
