package com.ssafy.yourpilling.presentation.component

import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.sp
import com.aay.compose.radarChart.RadarChart
import com.aay.compose.radarChart.model.NetLinesStyle
import com.aay.compose.radarChart.model.Polygon
import com.aay.compose.radarChart.model.PolygonStyle

@Composable
fun AnalysisRadarChart(
    radarLabels: List<String>,
    excessiveTakes: List<Double>,
    userTakes: List<Double>,
    recommendedIntakes: List<Double>
) {

    val adjust = adjust(userTakes, recommendedIntakes)

    val labelsStyle = TextStyle(
        color = Color.White,
        fontFamily = FontFamily.Serif,
        fontWeight = FontWeight.Medium,
        fontSize = 10.sp
    )

    val scalarValuesStyle = TextStyle(
        color = Color.White,
        fontFamily = FontFamily.Serif,
        fontWeight = FontWeight.Medium,
        fontSize = 10.sp
    )

    RadarChart(
        modifier = Modifier.fillMaxSize(),
        radarLabels = radarLabels,
        labelsStyle = labelsStyle,
        netLinesStyle = NetLinesStyle(
            netLineColor = Color(0xddddddD3),
            netLinesStrokeWidth = 2f,
            netLinesStrokeCap = StrokeCap.Butt
        ),
        scalarSteps = 3,
        scalarValue = 100.0,
        scalarValuesStyle = scalarValuesStyle,
        polygons = listOf(
            Polygon(
                values = adjust.first,
                unit = "%",
                style = PolygonStyle(
                    fillColor = Color(0xFFEE4351),
                    fillColorAlpha = 0.5f,
                    borderColor = Color(0xFFD35060),
                    borderColorAlpha = 0.5f,
                    borderStrokeWidth = 2f,
                    borderStrokeCap = StrokeCap.Butt
                )
            ),
            Polygon(
                values = adjust.second,
                unit = "%",
                style = PolygonStyle(
                    fillColor = Color(0xFFDAD077),
                    fillColorAlpha = 0.5f,
                    borderColor = Color(0xFFDFD280),
                    borderColorAlpha = 0.5f,
                    borderStrokeWidth = 2f,
                    borderStrokeCap = StrokeCap.Butt
                )
            ),
//            Polygon(
//                values = excessiveTakes,
//                unit = "$",
//                style = PolygonStyle(
//                    fillColor = Color(0xffc2ff86),
//                    fillColorAlpha = 0.5f,
//                    borderColor = Color(0xffe6ffd6),
//                    borderColorAlpha = 0.5f,
//                    borderStrokeWidth = 2f,
//                    borderStrokeCap = StrokeCap.Butt,
//                )
//            ),
        )
    )
}

@Composable
private fun adjust(
    userTakes: List<Double>,
    recommendedIntakes: List<Double>
) : Pair<List<Double>, List<Double>> {
    val adjustedUserTakes = userTakes.mapIndexed { index, item ->
        val recommended = recommendedIntakes[index]
        val ratio = if (recommended != 0.0) item / recommended else 1.0
        val adjusted = ratio * 100
        if (adjusted > 150) {
            150.0 // 최대값을 150으로 제한
        } else {
            adjusted
        }
    }

    val adjustedRecommendedIntakes = List(recommendedIntakes.size) { 100.0 }

    return Pair(adjustedUserTakes, adjustedRecommendedIntakes)
}