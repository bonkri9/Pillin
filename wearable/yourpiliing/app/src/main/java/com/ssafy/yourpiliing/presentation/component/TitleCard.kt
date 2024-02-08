package com.ssafy.yourpiliing.presentation.component

import android.content.SharedPreferences
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.ElevatedCard
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.style.TextAlign
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
    ElevatedCard(
        colors = CardDefaults.cardColors(
            containerColor = MaterialTheme.colorScheme.surfaceVariant,
        ),
        modifier = Modifier
            .size(width = 180.dp, height = 70.dp)
            .clickable {
                if(actualTakeCount < needToTakeTotalCount) {
                    takeOwnPillViewModel.take(TakeOwnPillRequest(ownPillId), sharedPreferences)
                }
            }
    ) {
        Text(
            text = title,
            modifier = Modifier
                .padding(16.dp),
        )
    }
}