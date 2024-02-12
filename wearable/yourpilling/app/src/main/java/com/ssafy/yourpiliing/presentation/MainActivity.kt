package com.ssafy.yourpilling.presentation

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.ui.platform.LocalContext
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.ssafy.yourpilling.presentation.page.LoginPage
import com.ssafy.yourpilling.presentation.page.MainPage
import com.ssafy.yourpilling.presentation.theme.AppTheme
import com.ssafy.yourpilling.presentation.viewmodel.AnalysisViewModel
import com.ssafy.yourpilling.presentation.viewmodel.FcmViewModel
import com.ssafy.yourpilling.presentation.viewmodel.HistoryViewModel
import com.ssafy.yourpilling.presentation.viewmodel.LoginViewModel
import com.ssafy.yourpilling.presentation.viewmodel.TakeOwnPillViewModel
import com.ssafy.yourpilling.presentation.viewmodel.WeeklyViewModel

class MainActivity : ComponentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // permission()

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

//    private fun permission() {
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
//            val permission = android.Manifest.permission.POST_NOTIFICATIONS
//            if (ActivityCompat.checkSelfPermission(this, permission) != PackageManager.PERMISSION_GRANTED) {
//                // 권한 요청
//                val permissionLauncher = registerForActivityResult(ActivityResultContracts.RequestPermission()) { isGranted ->
//                    if (isGranted) {
//
//                    } else {
//                        // 알림 권한 거부됨
//                        // 사용자에게 알림 권한 필요성을 알리고 다시 요청하거나 다른 기능을 제안
//                    }
//                }
//                permissionLauncher.launch(permission)
//            } else {
//
//            }
//        } else {
//            // android 12이하
//        }
//    }
}
