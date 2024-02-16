package com.example.yourpilling.presentation

import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.ui.platform.LocalContext
import androidx.core.app.ActivityCompat
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.example.yourpilling.presentation.page.LoginPage
import com.example.yourpilling.presentation.page.MainPage
import com.example.yourpilling.presentation.theme.AppTheme
import com.example.yourpilling.presentation.viewmodel.AnalysisViewModel
import com.example.yourpilling.presentation.viewmodel.FcmViewModel
import com.example.yourpilling.presentation.viewmodel.HistoryViewModel
import com.example.yourpilling.presentation.viewmodel.LoginViewModel
import com.example.yourpilling.presentation.viewmodel.TakeOwnPillViewModel
import com.example.yourpilling.presentation.viewmodel.WeeklyViewModel

class MainActivity : ComponentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        permission()

        setContent {
            AppTheme {
                val navController = rememberNavController()

                val loginViewModel = LoginViewModel()
                val fcmViewModel = FcmViewModel()
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
                            fcmViewModel = fcmViewModel,
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
            }
        }
    }

    private fun permission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            val permissions = arrayOf(
                android.Manifest.permission.POST_NOTIFICATIONS,
                android.Manifest.permission.INTERNET
            )
            val permissionLauncher = registerForActivityResult(ActivityResultContracts.RequestMultiplePermissions()) { permissionResults ->
                permissionResults.forEach { (permission, isGranted) ->
                    if (isGranted) {
                        // 권한 허용됨
                    } else {
                        // 권한 거부됨
                        // 사용자에게 권한 필요성을 알리고 다시 요청하거나 다른 기능을 제안
                    }
                }
            }
            permissionLauncher.launch(permissions)
        } else {
            // android 12이하
        }
    }
}
