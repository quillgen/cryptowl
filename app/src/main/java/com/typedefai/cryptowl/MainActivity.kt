package com.typedefai.cryptowl

import android.os.Bundle
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.lifecycle.ViewModelProvider
import coil3.ImageLoader
import coil3.compose.setSingletonImageLoaderFactory
import coil3.svg.SvgDecoder
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
            setSingletonImageLoaderFactory { context ->
                ImageLoader.Builder(context)
                    .components { add(SvgDecoder.Factory()) }
                    .build()
            }
            MaterialTheme {
                val screen by viewModel.screen.collectAsState()
                when (screen) {
                    AppScreen.Loading -> Unit
                    AppScreen.Intro -> IntroScreen(onStart = viewModel::startOnboarding)
                    AppScreen.PasswordSetup -> MasterPasswordScreen(viewModel)
                    AppScreen.BiometricSetup -> BiometricSetupScreen(viewModel)
                    AppScreen.Home -> VaultHomeScreen(viewModel)
                    AppScreen.Unlock -> UnlockScreen(viewModel)
                    AppScreen.Moments -> MomentsScreen(viewModel)
                }
            }
        }
    }
}
