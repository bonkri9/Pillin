package com.ssafy.yourpilling.presentation.page

import android.content.Context
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.wrapContentSize
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp
import androidx.wear.compose.material.Text
import com.ssafy.yourpilling.presentation.component.WeeklyHexagonalCircles
import com.ssafy.yourpilling.presentation.retrofit.weekly.WeeklyState
import com.ssafy.yourpilling.presentation.viewmodel.WeeklyViewModel

@Composable
fun WeeklyPage(weeklyViewModel: WeeklyViewModel) {
    val sharedPreferences = LocalContext.current.getSharedPreferences("auth", Context.MODE_PRIVATE);

    val weeklyState by weeklyViewModel.weeklyState.collectAsState(WeeklyState.Loading)

    LaunchedEffect(Unit) {
        weeklyViewModel.weekly(sharedPreferences)
    }

    Box(
        modifier = Modifier.fillMaxSize(),
        contentAlignment = Alignment.Center
    ) {
        when (weeklyState) {
            is WeeklyState.Loading -> {
                //TODO: 로딩중 메시지 띄우기
            }

            is WeeklyState.Success -> {
                val data = (weeklyState as WeeklyState.Success).response
                WeeklyHexagonalCircles(data)
            }

            is WeeklyState.Failure -> {
                //TODO: 실패 메시지 띄우기
            }
        }
    }
}