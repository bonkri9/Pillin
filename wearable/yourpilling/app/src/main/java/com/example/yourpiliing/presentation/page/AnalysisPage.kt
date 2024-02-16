package com.example.yourpilling.presentation.page

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
import com.example.yourpilling.presentation.component.AnalysisRadarChart
import com.example.yourpilling.presentation.retrofit.analysis.AnalysisState
import com.example.yourpilling.presentation.retrofit.analysis.ExtractionAnalysisResponse
import com.example.yourpilling.presentation.viewmodel.AnalysisViewModel

@Composable
fun AnalysisPage(analysisViewModel: AnalysisViewModel) {
    val sharedPreferences = LocalContext.current.getSharedPreferences("auth", Context.MODE_PRIVATE)
    val analysisState by analysisViewModel.analysisState.collectAsState(AnalysisState.Loading)

    LaunchedEffect(Unit) {
        analysisViewModel.analysis(sharedPreferences)
    }

    Box(
        modifier = Modifier.fillMaxSize(),
        contentAlignment = Alignment.Center
    ) {
        when (analysisState) {
            is AnalysisState.Loading -> {
                // TODO: 로딩 메시지 출력
            }

            is AnalysisState.Success -> {
                val datas =
                    (analysisState as AnalysisState.Success).response.essentialNutrientsDataList

                val extractionAnalysisResponse = ExtractionAnalysisResponse(datas)
                AnalysisRadarChart(
                    radarLabels = extractionAnalysisResponse.nutrients,
                    excessiveTakes = extractionAnalysisResponse.excessiveTakes,
                    userTakes = extractionAnalysisResponse.userTakes,
                    recommendedIntakes = extractionAnalysisResponse.recommendedIntakes
                )
            }

            is AnalysisState.Failure -> {
                Text(text = "분석할 데이터가 없습니다.")
            }

            else -> {}
        }
    }


}