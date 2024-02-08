package com.ssafy.yourpiliing.presentation.page

import android.content.Context
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.livedata.observeAsState
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import androidx.wear.compose.material.Scaffold
import com.ssafy.yourpiliing.presentation.component.TitleCard
import com.ssafy.yourpiliing.presentation.retrofit.dailyhistory.DailyHistoryState
import com.ssafy.yourpiliing.presentation.retrofit.take.TakeOwnPillState
import com.ssafy.yourpiliing.presentation.viewmodel.HistoryViewModel
import com.ssafy.yourpiliing.presentation.viewmodel.TakeOwnPillViewModel

@Composable
fun HistoryPage(navController: NavController, historyViewModel : HistoryViewModel, takeOwnPillViewModel : TakeOwnPillViewModel) {
    val sharedPreferences = LocalContext.current.getSharedPreferences("auth", Context.MODE_PRIVATE);

    val dailyHistoryState by historyViewModel.dailyHistoryState.observeAsState(DailyHistoryState.Loading)
    val takeOwnPillState by takeOwnPillViewModel.takeOwnPillState.collectAsState(TakeOwnPillState.Loading) // 영양제 복용 클릭

    // 화면 접근시 첫 출력을 위해 사용
    LaunchedEffect(Unit) {
        historyViewModel.dailyHistory(sharedPreferences)
    }

    LaunchedEffect(takeOwnPillState is TakeOwnPillState.Success) {
        historyViewModel.dailyHistory(sharedPreferences)
    }

    Box(
        contentAlignment = Alignment.Center,
        modifier = Modifier
            .fillMaxSize()
    ) {
        Column(
            modifier = Modifier.fillMaxWidth(),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            when (dailyHistoryState) {
                is DailyHistoryState.Loading -> {
                    // TODO: 로딩중 메시지 띄우기
                }

                is DailyHistoryState.Success -> {
                    val datas = (dailyHistoryState as DailyHistoryState.Success).response.taken

                    Column(
                        modifier = Modifier
                            .verticalScroll(rememberScrollState())
                            .padding(top = 40.dp, bottom = 40.dp)
                    ) {
                        for (data in datas) {
                            TitleCard(
                                title = data.name,
                                ownPillId = data.ownPillId,
                                needToTakeTotalCount = data.needToTakeTotalCount,
                                actualTakeCount = data.actualTakeCount,
                                takeOwnPillViewModel = takeOwnPillViewModel,
                                sharedPreferences = sharedPreferences
                            )
                            Spacer(modifier = Modifier.height(8.dp)) // 간격 추가
                        }
                    }
                }

                is DailyHistoryState.Failure -> {
                    // TODO: 실패 메시지 띄우기
                }
            }
        }
    }
}