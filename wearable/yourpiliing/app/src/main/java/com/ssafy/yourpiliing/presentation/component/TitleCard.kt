package com.ssafy.yourpiliing.presentation.component

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.unit.dp
import androidx.wear.compose.material.Text


@Composable
fun TitleCard(
    title: String,
    needToTakeTotalCount: Int,
    actualTakeCount: Int,
) {
    Box(
        modifier = Modifier
            .background(Color.Black.copy(alpha = 0.5f))
            .fillMaxWidth(0.8f)
            .padding(16.dp)
            .shadow(elevation = 4.dp)
    ) {
        Column(
            modifier = Modifier.fillMaxSize()
        ) {
            Text(
                text = title,
                style = TextStyle(color = Color.White), // 흰색 글자
            )
            Text(
                text = "섭취/필요: $actualTakeCount/$needToTakeTotalCount",
                style = TextStyle(color = Color.White),
            )
        }
    }
}