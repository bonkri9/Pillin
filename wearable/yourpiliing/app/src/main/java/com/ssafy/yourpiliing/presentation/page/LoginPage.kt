package com.ssafy.yourpilling.presentation.page

import android.content.Context
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.OutlinedTextField
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.livedata.observeAsState
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.unit.dp
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavController
import androidx.wear.compose.material.Button
import androidx.wear.compose.material.Text
import com.ssafy.yourpiliing.presentation.retrofit.login.LoginState
import com.ssafy.yourpiliing.presentation.viewmodel.LoginViewModel
import com.ssafy.yourpilling.presentation.retrofit.login.LoginRequest

@Composable
fun LoginPage(navController: NavController, loginViewModel: LoginViewModel) {
    val email = remember { mutableStateOf("") }
    val password = remember { mutableStateOf("") }

    val sharedPreferences = LocalContext.current.getSharedPreferences("auth", Context.MODE_PRIVATE);

    val loginState by loginViewModel.loginState.collectAsState(LoginState.Loading)

    Box(
        modifier = Modifier
            .background(Color.Black.copy(alpha = 0.5f))
            .padding(16.dp)
            .shadow(elevation = 4.dp)
            .fillMaxSize(),
        contentAlignment = Alignment.Center
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .verticalScroll(rememberScrollState()),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Text(text = "Pillin")
            Spacer(modifier = Modifier.height(4.dp))
            OutlinedTextField(
                value = email.value,
                onValueChange = { email.value = it },
                label = { Text("이메일 주소") }
            )
            Spacer(modifier = Modifier.height(4.dp))
            OutlinedTextField(
                value = password.value,
                onValueChange = { password.value = it },
                label = { Text("비밀번호") },
                visualTransformation = PasswordVisualTransformation()
            )
            Spacer(modifier = Modifier.height(4.dp))
            Button(
                onClick = {
                    val request = LoginRequest(email.value, password.value)
                    loginViewModel.login(request, sharedPreferences)
                }
            ) {
                Text("로그인")
            }

            when (loginState) {
                is LoginState.Loading -> {
                    // TODO: 로딩중 메시지 띄우기
                }

                is LoginState.Success -> {
                    // Pill 화면으로 이동
                    navController.navigate("history")
                }

                is LoginState.Failure -> {
                    // TODO: 실패 메시지 띄우기
                }
            }
        }
    }
}
