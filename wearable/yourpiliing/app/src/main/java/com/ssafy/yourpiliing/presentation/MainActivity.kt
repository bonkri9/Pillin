package com.ssafy.yourpiliing.presentation

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.ssafy.yourpiliing.presentation.page.AnalysisPage
import com.ssafy.yourpiliing.presentation.page.HistoryPage
import com.ssafy.yourpiliing.presentation.page.WeeklyPage
import com.ssafy.yourpiliing.presentation.theme.AppTheme
import com.ssafy.yourpiliing.presentation.viewmodel.AnalysisViewModel
import com.ssafy.yourpiliing.presentation.viewmodel.HistoryViewModel
import com.ssafy.yourpiliing.presentation.viewmodel.LoginViewModel
import com.ssafy.yourpiliing.presentation.viewmodel.TakeOwnPillViewModel
import com.ssafy.yourpiliing.presentation.viewmodel.WeeklyViewModel
import com.ssafy.yourpilling.presentation.page.LoginPage

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContent {
            //AppTheme {
            val navController = rememberNavController()

            val loginViewModel = LoginViewModel()
            val analysisViewModel = AnalysisViewModel()
            val historyViewModel = HistoryViewModel()
            val takeOwnPillViewModel = TakeOwnPillViewModel()
            val weeklyViewModel = WeeklyViewModel()

            NavHost(
                navController = navController,
                startDestination = "login"
            ) {
                composable("login") {
                    LoginPage(navController = navController, loginViewModel = loginViewModel)
                }
                composable("history") {
                    HistoryPage(
                        navController = navController,
                        historyViewModel = historyViewModel,
                        takeOwnPillViewModel = takeOwnPillViewModel
                    )
                }
                composable("analysis") {
                    AnalysisPage(
                        navController = navController,
                        analysisViewModel = analysisViewModel
                    )
                }
                composable("weekly"){
                    WeeklyPage(navController = navController, weeklyViewModel = weeklyViewModel)
                }
            }
            //}
        }
    }
}
