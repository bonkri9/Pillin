package com.ssafy.yourpiliing.presentation

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.ssafy.yourpiliing.presentation.page.HistoryPage
import com.ssafy.yourpilling.presentation.page.LoginPage

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContent {
            val navController = rememberNavController()

            NavHost(navController = navController,
                startDestination = "login") {
                composable("login"){
                    LoginPage(navController = navController)
                }
                composable("history"){
                    HistoryPage()
                }
            }
        }
    }
}

