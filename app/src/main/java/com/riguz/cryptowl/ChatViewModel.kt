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
    var thinkingText by mutableStateOf("")
    var tokenSpeed by mutableStateOf(0f)
    var latencyMs by mutableStateOf(-1f)
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

    var backendName by mutableStateOf(BACKEND_GPU_LABEL)
        private set

    // Sampler parameters (gallery defaults: topK=64, topP=0.95, temperature=1.0, maxTokens=4000).
    var topK by mutableStateOf(64)
        private set
    var topP by mutableStateOf(0.95f)
        private set
    var temperature by mutableStateOf(1.0f)
        private set
    var maxTokens by mutableStateOf(4000)
        private set

    /** Thinking mode (gallery ENABLE_THINKING toggle; Gemma 4 supports it). */
    var thinking by mutableStateOf(false)

    private var backend: Backend = Backend.GPU()
    private var modelDirectory: File? = null
    private var engine: Engine? = null
    private var conversation: Conversation? = null

    fun initializeModel(modelDirectory: File) {
        this.modelDirectory = modelDirectory
        viewModelScope.launch(Dispatchers.Default) {
            status = loadModel(modelDirectory)
            ready = conversation != null
        }
    }

    /**
     * Gemma 4 E2B has a known GPU precision-corruption issue on some GPUs
     * (garbled tokens, e.g. devanagari/corrupt fragments mid-response) — see
     * google-ai-edge/LiteRT-LM#2202; the documented workaround is the CPU
     * backend. Tapping the status line switches backends.
     */
    fun toggleBackend() {
        if (generating) return
        backend = if (backend is Backend.GPU) Backend.CPU() else Backend.GPU()
        backendName = if (backend is Backend.GPU) BACKEND_GPU_LABEL else BACKEND_CPU_LABEL
        val directory = modelDirectory ?: return
        viewModelScope.launch(Dispatchers.Default) {
            closeEngine()
            status = loadModel(directory)
            ready = conversation != null
        }
    }

    /** Applies new sampler parameters and starts a fresh conversation (gallery resetSession). */
    fun updateParameters(newTopK: Int, newTopP: Float, newTemperature: Float, newMaxTokens: Int) {
        if (generating) return
        topK = newTopK
        topP = newTopP
        temperature = newTemperature
        maxTokens = newMaxTokens
        resetConversation()
    }

    /** Clears the chat and creates a fresh conversation with the current parameters. */
    fun resetConversation() {
        if (generating) return
        _messages.clear()
        val engine = engine ?: return
        viewModelScope.launch(Dispatchers.Default) {
            try {
                conversation?.close()
            } catch (e: Exception) {
                Log.w(TAG, "Conversation close failed", e)
            }
            conversation = engine.createConversation(createConversationConfig())
            status = "New conversation ($backendName)"
        }
    }

    @OptIn(ExperimentalApi::class)
    private fun createConversationConfig() = ConversationConfig(
        samplerConfig = SamplerConfig(topK = topK, topP = topP.toDouble(), temperature = temperature.toDouble()),
    )

    private fun closeEngine() {
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
                loaded = Engine(engineConfig(modelFile, backend))
                loaded.initialize()
            } catch (e: Exception) {
                Log.w(TAG, "${backendName} backend failed, falling back to CPU", e)
                runCatching { loaded?.close() }
                backend = Backend.CPU()
                backendName = BACKEND_CPU_LABEL
                loaded = Engine(engineConfig(modelFile, backend))
                loaded.initialize()
            }
            ExperimentalFlags.enableSpeculativeDecoding = false

            engine = loaded
            conversation = loaded.createConversation(createConversationConfig())
            "Model ready: ${modelFile.name} ($backendName)"
        } catch (e: Exception) {
            Log.e(TAG, "Model load failed", e)
            "Model load failed: ${e.message}"
        }
    }

    private fun engineConfig(modelFile: File, backend: Backend) = EngineConfig(
        modelPath = modelFile.absolutePath,
        backend = backend,
        // Gemma 4 E2B is multimodal; the gallery enables vision+audio backends
        // for it even in chat (llmSupportImage/llmSupportAudio).
        visionBackend = Backend.GPU(),
        audioBackend = Backend.CPU(),
        maxNumTokens = maxTokens,
    )

    fun sendMessage(text: String) {
        val conversation = conversation ?: return
        _messages.add(ChatMessage(isUser = true).also { it.text = text })
        val reply = ChatMessage(isUser = false)
        _messages.add(reply)
        generating = true

        // Token speed + latency, like the gallery's latencyMs bookkeeping.
        val start = System.currentTimeMillis()
        var tokenCount = 0

        viewModelScope.launch(Dispatchers.Default) {
            val extraContext =
                if (thinking) mapOf(THINKING_CONTEXT_KEY to "true") else emptyMap()
            conversation.sendMessageAsync(
                Contents.of(listOf(Content.Text(text))),
                object : MessageCallback {
                    override fun onMessage(message: Message) {
                        val delta = message.toString()
                        if (delta.startsWith("<ctrl")) {
                            return
                        }
                        reply.text += delta
                        val thinkingDelta = message.channels[THOUGHT_CHANNEL]
                        if (!thinkingDelta.isNullOrEmpty()) {
                            reply.thinkingText += thinkingDelta
                        }
                        tokenCount++
                        val elapsedMs = (System.currentTimeMillis() - start).coerceAtLeast(1)
                        reply.tokenSpeed = tokenCount / (elapsedMs / 1000f)
                    }

                    override fun onDone() {
                        reply.latencyMs = (System.currentTimeMillis() - start).toFloat()
                        generating = false
                    }

                    override fun onError(throwable: Throwable) {
                        Log.e(TAG, "Inference failed", throwable)
                        reply.text = "Error: ${throwable.message}"
                        reply.latencyMs = (System.currentTimeMillis() - start).toFloat()
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

    /** Re-sends a user prompt (gallery runAgain). */
    fun runAgain(text: String) {
        sendMessage(text)
    }

    override fun onCleared() {
        closeEngine()
    }

    companion object {
        private const val TAG = "ChatViewModel"
        private const val MODEL_EXT = "litertlm"
        private const val BACKEND_GPU_LABEL = "GPU"
        private const val BACKEND_CPU_LABEL = "CPU"

        // Gallery Consts.kt + LlmChatViewModel.
        private const val THOUGHT_CHANNEL = "thought"
        private const val THINKING_CONTEXT_KEY = "enable_thinking"
    }
}
