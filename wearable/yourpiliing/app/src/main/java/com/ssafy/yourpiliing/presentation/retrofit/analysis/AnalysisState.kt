package com.ssafy.yourpiliing.presentation.retrofit.analysis

sealed class AnalysisState {
    object Loading : AnalysisState()
    data class Success(val response: AnalysisResponse) : AnalysisState()
    data class Failure(val message: String) : AnalysisState()
}
