package com.ssafy.yourpilling.presentation.fcm

import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage

class FcmServiceIml : FirebaseMessagingService() {

    override fun onNewToken(token: String) {
        super.onNewToken(token)
    }

    override fun onMessageReceived(message: RemoteMessage) {
        super.onMessageReceived(message)

        message.takeIf { it.data.isNotEmpty() }?.apply {
            // push를 전달 받으면 동장
        }
    }
}