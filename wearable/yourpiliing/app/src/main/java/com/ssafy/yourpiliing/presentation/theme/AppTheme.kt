package com.ssafy.yourpiliing.presentation.theme

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color

@Composable
fun AppTheme(content: @Composable () -> Unit) {
    MaterialTheme {
        Box(
            modifier = Modifier.background(AppColors.backgroundColor)
        ) {
            content()
        }
    }
}