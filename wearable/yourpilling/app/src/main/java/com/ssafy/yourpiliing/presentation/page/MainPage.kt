package com.ssafy.yourpilling.presentation.page

import android.content.Context
import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.wrapContentHeight
import androidx.compose.foundation.pager.HorizontalPager
import androidx.compose.foundation.pager.rememberPagerState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import com.ssafy.yourpilling.presentation.viewmodel.AnalysisViewModel
import com.ssafy.yourpilling.presentation.viewmodel.HistoryViewModel
import com.ssafy.yourpilling.presentation.viewmodel.TakeOwnPillViewModel
import com.ssafy.yourpilling.presentation.viewmodel.WeeklyViewModel

@OptIn(ExperimentalFoundationApi::class)
@Composable
fun MainPage(
    analysisViewModel: AnalysisViewModel,
    takeOwnPillViewModel: TakeOwnPillViewModel,
    historyViewModel: HistoryViewModel,
    weeklyViewModel: WeeklyViewModel
) {
    Box(
        modifier = Modifier
            .fillMaxSize(),
        contentAlignment = Alignment.Center

    ) {
        val pagerState = rememberPagerState(pageCount = { 3 })
        HorizontalPager(state = pagerState) { page ->
            when (pagerState.currentPage) {
                0 -> HistoryPage(
                    historyViewModel = historyViewModel,
                    takeOwnPillViewModel = takeOwnPillViewModel
                )
                1 -> AnalysisPage(
                    analysisViewModel = analysisViewModel
                )
                2 -> WeeklyPage(
                    weeklyViewModel = weeklyViewModel
                )
            }
        }
        Row(
            Modifier
                .wrapContentHeight()
                .fillMaxWidth()
                .align(Alignment.BottomCenter)
                .padding(bottom = 6.dp),
            horizontalArrangement = Arrangement.Center
        ) {
            repeat(pagerState.pageCount) { iteration ->
                val color =
                    if (pagerState.currentPage == iteration) Color.DarkGray else Color.LightGray
                Box(
                    modifier = Modifier
                        .padding(2.dp)
                        .clip(CircleShape)
                        .background(color)
                        .size(6.dp)
                )
            }
        }
    }
}