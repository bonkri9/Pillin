package com.ssafy.yourpiliing.presentation.component

import android.content.SharedPreferences
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.unit.dp
import androidx.wear.compose.material.Text
import com.ssafy.yourpiliing.presentation.retrofit.take.TakeOwnPillRequest
import com.ssafy.yourpiliing.presentation.viewmodel.TakeOwnPillViewModel


@Composable
fun TitleCard(
    title: String,
    ownPillId: Long,
    needToTakeTotalCount: Int,
    actualTakeCount: Int,
    takeOwnPillViewModel: TakeOwnPillViewModel,
    sharedPreferences: SharedPreferences
) {

    val ratio = (actualTakeCount.toFloat() / needToTakeTotalCount.toFloat()) * 100
    val gradient = Brush.horizontalGradient(
        colors = listOf(
            Color.Red,
            Color.Yellow,
            Color.Green
        ),
        startX = 0f,
        endX = ratio
    )

    Box(
        modifier = Modifier
            .fillMaxWidth()
            .padding(16.dp)
            .shadow(elevation = 4.dp)
            .background(gradient)
            .clickable {
                takeOwnPillViewModel.take(TakeOwnPillRequest(ownPillId), sharedPreferences)
            }
    ) {
        Text(
            text = title,
            style = TextStyle(color = Color.White),
            modifier = Modifier.padding(16.dp)
        )
    }
}