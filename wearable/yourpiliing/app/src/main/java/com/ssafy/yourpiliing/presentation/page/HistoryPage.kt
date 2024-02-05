package com.ssafy.yourpiliing.presentation.page

import android.content.Context
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.livedata.observeAsState
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp
import com.ssafy.yourpiliing.presentation.component.TitleCard
import com.ssafy.yourpiliing.presentation.retrofit.dailyhistory.DailyHistoryState
import com.ssafy.yourpiliing.presentation.viewmodel.HistoryViewModel

@Composable
fun HistoryPage(){
     val sharedPreferences = LocalContext.current.getSharedPreferences("auth", Context.MODE_PRIVATE);

    val historyViewModel = HistoryViewModel()
    LaunchedEffect(Unit){
        historyViewModel.dailyHistory(sharedPreferences)
    }

    val dailyHistoryState by historyViewModel.dailyHistoryResponse.observeAsState(DailyHistoryState.Loading)

    Box(
        modifier = Modifier.fillMaxSize(),
        contentAlignment = Alignment.Center
    ){
        Column(
            modifier = Modifier.fillMaxWidth(),
            horizontalAlignment = Alignment.CenterHorizontally
        ){
            when(dailyHistoryState){
                is DailyHistoryState.Loading -> {
                    // TODO: 로딩중 메시지 띄우기
                }
                is DailyHistoryState.Success -> {
                    val datas = (dailyHistoryState as DailyHistoryState.Success).response.taken

                    Column(modifier = Modifier.verticalScroll(rememberScrollState())) {
                        for (data in datas){
                            TitleCard(
                                title = data.name,
                                needToTakeTotalCount = data.needToTakeTotalCount,
                                actualTakeCount = data.actualTakeCount,
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