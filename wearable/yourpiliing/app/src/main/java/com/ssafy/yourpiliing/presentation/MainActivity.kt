package com.ssafy.yourpiliing.presentation

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.ui.platform.LocalContext
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.ssafy.yourpiliing.presentation.page.MainPage
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
                    LoginPage(
                        navController = navController,
                        loginViewModel = loginViewModel,
                        context = LocalContext.current
                    )
                }
                composable("main") {
                    MainPage(
                        analysisViewModel = analysisViewModel,
                        takeOwnPillViewModel = takeOwnPillViewModel,
                        historyViewModel = historyViewModel,
                        weeklyViewModel = weeklyViewModel
                    )
                }
            }
            //}
        }
    }
}
