package com.typedefai.cryptowl

import android.os.Bundle
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.lifecycle.ViewModelProvider
import com.typedefai.cryptowl.onboarding.BiometricSetupScreen
import com.typedefai.cryptowl.onboarding.IntroScreen
import com.typedefai.cryptowl.onboarding.MasterPasswordScreen

class MainActivity : AppCompatActivity() {

    private val viewModel: MainViewModel by lazy {
        ViewModelProvider(this)[MainViewModel::class.java]
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()

        setContent {
            MaterialTheme {
                val screen by viewModel.screen.collectAsState()
                when (screen) {
                    AppScreen.Loading -> Unit
                    AppScreen.Intro -> IntroScreen(onStart = viewModel::startOnboarding)
                    AppScreen.PasswordSetup -> MasterPasswordScreen(viewModel)
                    AppScreen.BiometricSetup -> BiometricSetupScreen(viewModel)
                    AppScreen.Home -> VaultHomeScreen()
                }
            }
        }
    }
}
