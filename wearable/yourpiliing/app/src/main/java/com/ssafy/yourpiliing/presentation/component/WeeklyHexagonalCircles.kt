package com.ssafy.yourpiliing.presentation.component

import androidx.compose.animation.core.Animatable
import androidx.compose.animation.core.LinearEasing
import androidx.compose.animation.core.tween
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.Size
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Paint
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.graphics.drawscope.drawIntoCanvas
import androidx.compose.ui.graphics.nativeCanvas
import androidx.compose.ui.graphics.toArgb
import com.ssafy.yourpiliing.presentation.retrofit.weekly.WeeklyResponseItem
import java.time.LocalDate
import kotlin.math.cos
import kotlin.math.sin

@Composable
fun WeeklyHexagonalCircles(
    data: List<WeeklyResponseItem>
) {

    val startAngle = 270f
    val radius = 50f
    val stroke = 3.5f
    val fontColor = Color.White

    val animateFloat = remember { Animatable(0f) }
    LaunchedEffect(animateFloat) {
        animateFloat.animateTo(
            targetValue = 1f,
            animationSpec = tween(durationMillis = 3000, easing = LinearEasing)
        )
    }

    Box(
        modifier = Modifier
            .fillMaxSize(),
        contentAlignment = Alignment.Center
    ) {
        // 육각형 패턴 계산
        val hexagonPoints =
            calculateHexagonPoints(radius = 140f, center = Offset(225f, 225f)) // 중심 위치 변경

        // 원 표시
        Canvas(modifier = Modifier.fillMaxSize()) {
            var formattedDate = formatDate(data[0].date)
            var ratio = calRatio(data[0])

            // 가운데 원
            drawCircle(
                color = Color.Gray,
                radius = radius,
                center = center
            )
            drawIntoCanvas {
                val textPaint = Paint().asFrameworkPaint().apply {
                    color = fontColor.toArgb()
                    textSize = 20f
                }
                val textWidth = textPaint.measureText(formattedDate)
                it.nativeCanvas.drawText(
                    formattedDate,
                    center.x - textWidth / 2, // 가운데 정렬
                    center.y + 7f, // 수직 정렬 조정
                    textPaint
                )
            }
            drawArc(
                color = calculateColor(ratio),
                startAngle = startAngle,
                sweepAngle = 360f * ratio,
                useCenter = false,
                topLeft = Offset(center.x - radius, center.y - radius),
                size = Size(radius * 2, radius * 2),
                style = Stroke(stroke)
            )

            // 육각형 배치된 원
            hexagonPoints.forEachIndexed { index, point ->
                formattedDate = formatDate(data[index+1].date)
                ratio = calRatio(data[index+1])

                drawCircle(
                    color = Color.Gray,
                    radius = radius,
                    center = point
                )

                // 원 내부에 글자 표시
                drawIntoCanvas {
                    val textPaint = Paint().asFrameworkPaint().apply {
                        color = fontColor.toArgb()
                        textSize = 20f
                    }
                    val textWidth = textPaint.measureText(formattedDate)
                    it.nativeCanvas.drawText(
                        formattedDate,
                        point.x - textWidth / 2, // 가운데 정렬
                        point.y + 7f, // 수직 정렬 조정
                        textPaint
                    )
                }

                // 원의 중심을 기준으로 아크를 그림
                drawArc(
                    color = calculateColor(ratio),
                    startAngle = startAngle,
                    sweepAngle = 360f * calRatio((data[index+1])),
                    useCenter = false,
                    topLeft = Offset(point.x - radius, point.y - radius), // 수정된 topLeft
                    size = Size(radius * 2, radius * 2),
                    style = Stroke(stroke)
                )
            }
        }
    }
}

fun calRatio(item: WeeklyResponseItem): Float {
    if(item.needToTakenCountToday == 0) return 0f

    return (item.actualTakenToday.toFloat() / item.needToTakenCountToday);
}

fun calculateColor(ratio: Float): Color {
    return when {
        ratio <= 0.2f -> Color.Red
        ratio < 0.5f -> Color(1.0f, 0.5f, 0.0f) // Orange
        else -> Color.Green
    }
}

// 육각형 점 계산 함수
fun calculateHexagonPoints(radius: Float, center: Offset): List<Offset> {
    val angleStep = 360f / 6f
    val points = mutableListOf<Offset>()

    for (i in 0 until 6) {
        val angle = angleStep * i
        val radians = angle * Math.PI / 180 // 각도를 라디안으로 변환
        val x = (radius * cos(radians) + center.x).toFloat()
        val y = (radius * sin(radians) + center.y).toFloat()
        points.add(Offset(x, y))
    }

    return points
}

fun formatDate(date: String): String {
    val dateToLocalDate = LocalDate.parse(date)
    val month = dateToLocalDate.monthValue.toString().padStart(2, '0')
    val day = dateToLocalDate.dayOfMonth.toString().padStart(2, '0')
    return "$month.$day"
}
