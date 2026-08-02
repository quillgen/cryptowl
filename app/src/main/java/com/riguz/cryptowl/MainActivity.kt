package com.riguz.cryptowl

import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.util.Log
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.updatePadding
import androidx.lifecycle.lifecycleScope
import androidx.recyclerview.widget.LinearLayoutManager
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
import com.riguz.cryptowl.databinding.ActivityMainBinding
import java.io.File
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding
    private val adapter = ChatAdapter(AGENT_NAME)
    private var engine: Engine? = null
    private var conversation: Conversation? = null
    private var generating = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        WindowCompat.setDecorFitsSystemWindows(window, false)
        ViewCompat.setOnApplyWindowInsetsListener(binding.root) { _, insets ->
            val bars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            val ime = insets.getInsets(WindowInsetsCompat.Type.ime())
            binding.inputBar.updatePadding(bottom = maxOf(bars.bottom, ime.bottom))
            binding.textStatus.updatePadding(top = bars.top)
            WindowInsetsCompat.CONSUMED
        }

        binding.recyclerChat.layoutManager = LinearLayoutManager(this)
        binding.recyclerChat.adapter = adapter
        binding.buttonSend.setOnClickListener { sendMessage() }
        binding.buttonAdd.setOnClickListener {
            Toast.makeText(this, "Attachments are not supported yet", Toast.LENGTH_SHORT).show()
        }
        binding.editMessage.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}
            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {}
            override fun afterTextChanged(s: Editable?) {
                updateSendButton()
            }
        })

        initializeModel()
    }

    private fun updateSendButton() {
        val enabled = !generating && !binding.editMessage.text.isNullOrBlank() && conversation != null
        binding.buttonSend.isEnabled = enabled
        binding.buttonSend.alpha = if (enabled) 1f else 0.3f
    }

    @OptIn(ExperimentalApi::class)
    private fun initializeModel() {
        binding.textStatus.text = "Loading model..."
        lifecycleScope.launch {
            val status = withContext(Dispatchers.Default) { loadModel() }
            binding.textStatus.text = status
            updateSendButton()
        }
    }

    @OptIn(ExperimentalApi::class)
    private fun loadModel(): String {
        val modelFile = findModelFile()
            ?: return "No model found in:\n${modelDirectory()}"
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
                    samplerConfig = SamplerConfig(topK = 40, topP = 0.95, temperature = 0.8),
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

    private fun sendMessage() {
        val text = binding.editMessage.text?.toString()?.trim().orEmpty()
        if (text.isEmpty() || generating) return
        val conversation = conversation ?: return

        binding.editMessage.setText("")
        adapter.add(ChatMessage(isUser = true, text = text))
        val reply = adapter.add(ChatMessage(isUser = false, text = ""))
        generating = true
        updateSendButton()
        binding.recyclerChat.scrollToPosition(adapter.itemCount - 1)

        lifecycleScope.launch {
            withContext(Dispatchers.Default) {
                conversation.sendMessageAsync(
                    Contents.of(listOf(Content.Text(text))),
                    object : MessageCallback {
                        override fun onMessage(message: Message) {
                            runOnUiThread {
                                reply.text = message.toString()
                                adapter.lastChanged()
                                binding.recyclerChat.scrollToPosition(adapter.itemCount - 1)
                            }
                        }

                        override fun onDone() {
                            runOnUiThread {
                                generating = false
                                updateSendButton()
                            }
                        }

                        override fun onError(throwable: Throwable) {
                            Log.e(TAG, "Inference failed", throwable)
                            runOnUiThread {
                                reply.text = "Error: ${throwable.message}"
                                adapter.lastChanged()
                                generating = false
                                updateSendButton()
                            }
                        }
                    },
                    emptyMap(),
                )
            }
        }
    }

    private fun modelDirectory(): String =
        File(getExternalFilesDir(null), MODEL_DIR).absolutePath

    private fun findModelFile(): File? {
        val dir = File(getExternalFilesDir(null), MODEL_DIR)
        return dir.listFiles { file -> file.extension == MODEL_EXT }?.firstOrNull()
    }

    override fun onDestroy() {
        super.onDestroy()
        if (isFinishing) {
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
    }

    companion object {
        private const val TAG = "MainActivity"
        private const val MODEL_DIR = "model"
        private const val MODEL_EXT = "litertlm"
        private const val MAX_TOKENS = 1024
        private const val AGENT_NAME = "Gemma 4 E2B"
    }
}
