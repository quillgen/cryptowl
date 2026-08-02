package com.riguz.cryptowl

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.material3.MaterialTheme
import androidx.lifecycle.ViewModelProvider
import java.io.File

class MainActivity : ComponentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()

        val chatViewModel = ViewModelProvider(this)[ChatViewModel::class.java]
        chatViewModel.initializeModel(File(getExternalFilesDir(null), MODEL_DIR))

        setContent {
            MaterialTheme {
                ChatScreen(viewModel = chatViewModel, agentName = AGENT_NAME)
            }
        }
    }

    companion object {
        private const val MODEL_DIR = "model"
        private const val AGENT_NAME = "Gemma 4 E2B"
    }
}
