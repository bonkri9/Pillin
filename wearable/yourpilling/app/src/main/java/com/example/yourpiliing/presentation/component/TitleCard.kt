package com.example.yourpilling.presentation.component

import android.content.SharedPreferences
import androidx.compose.foundation.Image
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.CardColors
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.ElevatedCard
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.painter.Painter
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.wear.compose.material.Text
import com.example.yourpilling.R
import com.example.yourpilling.presentation.retrofit.take.TakeOwnPillRequest
import com.example.yourpilling.presentation.theme.AppColors
import com.example.yourpilling.presentation.viewmodel.TakeOwnPillViewModel


@Composable
fun TitleCard(
    title: String,
    ownPillId: Long,
    needToTakeTotalCount: Int,
    actualTakeCount: Int,
    takeCount: Int,
    takeOwnPillViewModel: TakeOwnPillViewModel,
    sharedPreferences: SharedPreferences
) {
    val takeOnceAmount = needToTakeTotalCount / takeCount
    val isAllAte = (actualTakeCount == needToTakeTotalCount)

    ElevatedCard(
        colors = cardColors(actualTakeCount, needToTakeTotalCount),
        modifier = Modifier
            .fillMaxWidth(0.97f)
            .height(55.dp)
            .clickable {
                if (actualTakeCount < needToTakeTotalCount) {
                    takeOwnPillViewModel.take(TakeOwnPillRequest(ownPillId), sharedPreferences)
                }
            },
        shape = RoundedCornerShape(percent = 42),
    ) {
        Row(
            verticalAlignment = Alignment.CenterVertically,
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 12.dp, vertical = 10.dp)
        ) {
            Box(
                modifier = Modifier.size(40.dp),
                contentAlignment = Alignment.Center
            ) {
                Image(
                    painter = pillImage(isAllAte),
                    contentDescription = null,
                    modifier = Modifier.size(24.dp)
                )
                Box(
                    modifier = Modifier
                        .fillMaxSize()
                        .padding(6.dp),
                    contentAlignment = Alignment.BottomEnd
                ) {
                    Text(
                        text = "$takeOnceAmount",
                        color = Color.White,
                        fontSize = 12.sp
                    )
                }
            }

            // 텍스트 추가
            Text(
                text = title,
                modifier = Modifier
                    .padding(start = 6.dp)
                    .weight(1f),
                overflow = TextOverflow.Ellipsis,
                maxLines = 1
            )
        }
    }

}

@Composable
private fun pillImage(
    isAllAte : Boolean
) : Painter {
    if(isAllAte){
        return painterResource(id = R.drawable.ate)
    }
    return painterResource(id = R.drawable.one_pill)
}

@Composable
private fun cardColors(
    actualTakeCount: Int,
    needToTakeTotalCount: Int
): CardColors {
    if (actualTakeCount >= needToTakeTotalCount) {
        return CardDefaults.cardColors(
            containerColor = AppColors.grayWithOpacity
        )
    }
    return CardDefaults.cardColors(
        containerColor = AppColors.cardColors
    )
}
