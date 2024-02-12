package com.ssafy.yourpilling.presentation.page

import android.content.Context
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.wrapContentSize
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.livedata.observeAsState
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.wear.compose.material.Text
import com.ssafy.yourpilling.presentation.component.TitleCard
import com.ssafy.yourpilling.presentation.retrofit.dailyhistory.DailyHistoryState
import com.ssafy.yourpilling.presentation.retrofit.take.TakeOwnPillState
import com.ssafy.yourpilling.presentation.viewmodel.HistoryViewModel
import com.ssafy.yourpilling.presentation.viewmodel.TakeOwnPillViewModel

@Composable
fun HistoryPage(historyViewModel : HistoryViewModel,
                takeOwnPillViewModel : TakeOwnPillViewModel
) {
    val sharedPreferences = LocalContext.current.getSharedPreferences("auth", Context.MODE_PRIVATE);

    val dailyHistoryState by historyViewModel.dailyHistoryState.observeAsState(DailyHistoryState.Loading)
    val takeOwnPillState by takeOwnPillViewModel.takeOwnPillState.collectAsState(TakeOwnPillState.Loading)

    // 화면 접근시 첫 출력을 위해 사용
    LaunchedEffect(Unit) {
        historyViewModel.dailyHistory(sharedPreferences)
    }

    // 복용 버튼 클릭시 리컴포즈
    LaunchedEffect(takeOwnPillState is TakeOwnPillState.Success) {
        historyViewModel.dailyHistory(sharedPreferences)
        historyViewModel.resetState() // 제거하면 한 번만 리컴포즈 됨
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
                    //TODO: 로딩중 메시지 띄우기
                }

                is DailyHistoryState.Success -> {
                    val datas = (dailyHistoryState as DailyHistoryState.Success).response.taken

                    Column(
                        modifier = Modifier
                            .verticalScroll(rememberScrollState())
                            .padding(top = 40.dp, bottom = 40.dp)

                    ) {
                        Text(
                            text = "오늘 먹을 영양제",
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(bottom = 20.dp, top = 10.dp) // 텍스트 사이의 간격 추가
                                .wrapContentSize(Alignment.Center) // 텍스트를 세로 방향으로 중앙에 정렬
                        )

                        if(datas.isNotEmpty()){
                            for (data in datas) {
                                TitleCard(
                                    title = data.name,
                                    ownPillId = data.ownPillId,
                                    needToTakeTotalCount = data.needToTakeTotalCount,
                                    actualTakeCount = data.actualTakeCount,
                                    takeCount = data.takeCount,
                                    takeOwnPillViewModel = takeOwnPillViewModel,
                                    sharedPreferences = sharedPreferences
                                )
                                Spacer(modifier = Modifier.height(5.dp)) // 간격 추가
                            }
                        }else{
                            Text(
                                text = "오늘 먹을 영양제가 없습니다.",
                                textAlign = TextAlign.Center,
                                modifier = Modifier.fillMaxWidth()
                            )
                        }
                    }
                }

                is DailyHistoryState.Failure -> {
                    //TODO: 실패 메시지 띄우기
                }
            }
        }
    }
}