package com.ssafy.yourpilling.presentation.page

import android.content.Context
import android.widget.Toast
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
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import androidx.wear.compose.material.Button
import androidx.wear.compose.material.ButtonDefaults
import androidx.wear.compose.material.Text
import com.ssafy.yourpiliing.presentation.retrofit.login.LoginState
import com.ssafy.yourpiliing.presentation.theme.AppColors
import com.ssafy.yourpiliing.presentation.viewmodel.LoginViewModel
import com.ssafy.yourpilling.presentation.retrofit.login.LoginRequest

@Composable
fun LoginPage(navController: NavController, loginViewModel: LoginViewModel, context: Context) {
    val email = remember { mutableStateOf("") }
    val password = remember { mutableStateOf("") }

    val sharedPreferences = LocalContext.current.getSharedPreferences("auth", Context.MODE_PRIVATE);

    val loginState by loginViewModel.loginState.collectAsState(LoginState.Loading)

    Box(
        modifier = Modifier
            .background(Color.Black.copy(alpha = 0.5f))
            .padding(16.dp)
            .fillMaxSize(),
        contentAlignment = Alignment.Center
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .verticalScroll(rememberScrollState()),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Text(
                text = "로그인",
                color = AppColors.mainColor
            )
            Spacer(modifier = Modifier.height(4.dp))
            OutlinedTextField(
                value = email.value,
                onValueChange = { email.value = it },
                label = { Text("이메일 주소") },
                modifier = Modifier
                    .fillMaxWidth(0.9f)
                    .height(40.dp)
            )
            Spacer(modifier = Modifier.height(15.dp))
            OutlinedTextField(
                value = password.value,
                onValueChange = { password.value = it },
                label = { Text("비밀번호") },
                visualTransformation = PasswordVisualTransformation(),
                modifier = Modifier
                    .fillMaxWidth(0.9f)
                    .height(40.dp)
            )
            Spacer(modifier = Modifier.height(15.dp))
            Button(
                onClick = {
                    val request = LoginRequest(email.value, password.value)
                    loginViewModel.login(request, sharedPreferences) { isSuccess, message ->
                        if(!isSuccess){
                            Toast.makeText(context, message, Toast.LENGTH_SHORT).show()
                        }
                    }
                },
                modifier = Modifier
                    .fillMaxWidth(0.9f)
                    .height(30.dp),
                colors = ButtonDefaults.buttonColors(backgroundColor = AppColors.mainColor)
            ) {
                Text("입장하기")
            }

            when (loginState) {
                is LoginState.Success -> {
                    navController.navigate("main")
                }

                else->{}
            }
        }
    }
}
