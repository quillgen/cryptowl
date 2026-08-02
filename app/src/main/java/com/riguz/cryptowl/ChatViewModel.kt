package com.riguz.cryptowl

import android.util.Log
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.google.ai.edge.litertlm.Backend
import com.google.ai.edge.litertlm.Content
import com.google.ai.edge.litertlm.Contents
import com.google.ai.edge.litertlm.Conversation
import com.google.ai.edge.litertlm.ConversationConfig
import com.google.ai.edge.litertlm.Engine
import com.google.ai.edge.litertlm.EngineConfig
import com.google.ai.edge.litertlm.ExperimentalApi
import com.google.ai.edge.litertlm.ExperimentalFlags
import com.google.ai.edge.litertlm.Message
import com.google.ai.edge.litertlm.MessageCallback
import com.google.ai.edge.litertlm.SamplerConfig
import java.io.File
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

data class ChatMessage(val isUser: Boolean) {
    var text by mutableStateOf("")
}

class ChatViewModel : ViewModel() {

    private val _messages = mutableStateListOf<ChatMessage>()
    val messages: List<ChatMessage> get() = _messages

    var status by mutableStateOf("Loading model...")
        private set

    var ready by mutableStateOf(false)
        private set

    var generating by mutableStateOf(false)
        private set

    private var engine: Engine? = null
    private var conversation: Conversation? = null

    fun initializeModel(modelDirectory: File) {
        viewModelScope.launch(Dispatchers.Default) {
            status = loadModel(modelDirectory)
            ready = conversation != null
        }
    }

    @OptIn(ExperimentalApi::class)
    private fun loadModel(modelDirectory: File): String {
        val modelFile = modelDirectory.listFiles { file -> file.extension == MODEL_EXT }?.firstOrNull()
            ?: return "No model found in:\n${modelDirectory.absolutePath}"
        return try {
            // Mirror gallery: disable experimental flags explicitly around engine
            // and conversation creation.
            ExperimentalFlags.enableSpeculativeDecoding = false
            var loaded: Engine? = null
            try {
                loaded = Engine(engineConfig(modelFile, Backend.GPU()))
                loaded.initialize()
            } catch (e: Exception) {
                Log.w(TAG, "GPU backend failed, falling back to CPU", e)
                runCatching { loaded?.close() }
                loaded = Engine(engineConfig(modelFile, Backend.CPU()))
                loaded.initialize()
            }
            ExperimentalFlags.enableSpeculativeDecoding = false

            engine = loaded
            ExperimentalFlags.enableConversationConstrainedDecoding = false
            conversation = loaded.createConversation(
                ConversationConfig(
                    samplerConfig = SamplerConfig(topK = TOP_K, topP = TOP_P, temperature = TEMPERATURE),
                ),
            )
            ExperimentalFlags.enableConversationConstrainedDecoding = false
            "Model ready: ${modelFile.name}"
        } catch (e: Exception) {
            Log.e(TAG, "Model load failed", e)
            "Model load failed: ${e.message}"
        }
    }

    private fun engineConfig(modelFile: File, backend: Backend) = EngineConfig(
        modelPath = modelFile.absolutePath,
        backend = backend,
        maxNumTokens = MAX_TOKENS,
    )

    fun sendMessage(text: String) {
        val conversation = conversation ?: return
        _messages.add(ChatMessage(isUser = true).also { it.text = text })
        val reply = ChatMessage(isUser = false)
        _messages.add(reply)
        generating = true

        viewModelScope.launch(Dispatchers.Default) {
            conversation.sendMessageAsync(
                Contents.of(listOf(Content.Text(text))),
                object : MessageCallback {
                    override fun onMessage(message: Message) {
                        val delta = message.toString()
                        if (delta.startsWith("<ctrl")) {
                            return
                        }
                        reply.text += delta
                    }

                    override fun onDone() {
                        generating = false
                    }

                    override fun onError(throwable: Throwable) {
                        Log.e(TAG, "Inference failed", throwable)
                        reply.text = "Error: ${throwable.message}"
                        generating = false
                    }
                },
                emptyMap(),
            )
        }
    }

    fun stopResponse() {
        try {
            conversation?.cancelProcess()
        } catch (e: IllegalStateException) {
            Log.w(TAG, "Conversation is not alive, cannot cancel process", e)
        }
    }

    override fun onCleared() {
        try {
            conversation?.close()
        } catch (e: Exception) {
            Log.w(TAG, "Conversation close failed", e)
        }
        try {
            engine?.close()
        } catch (e: Exception) {
            Log.w(TAG, "Engine close failed", e)
        }
        engine = null
        conversation = null
    }

    companion object {
        private const val TAG = "ChatViewModel"
        private const val MODEL_EXT = "litertlm"

        // Gemma-4-E2B-it defaults from the gallery model allowlist
        // (model_allowlists/1_0_15.json): topK=64, topP=0.95, temperature=1.0,
        // maxTokens=4000. Thinking and MTP stay off (gallery defaults).
        private const val TOP_K = 64
        private const val TOP_P = 0.95
        private const val TEMPERATURE = 1.0
        private const val MAX_TOKENS = 4000
    }
}
