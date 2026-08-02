package com.riguz.cryptowl

import androidx.compose.animation.AnimatedVisibility
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.imePadding
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.offset
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.rounded.Send
import androidx.compose.material.icons.outlined.Add
import androidx.compose.material.icons.rounded.KeyboardArrowDown
import androidx.compose.material.icons.rounded.RestartAlt
import androidx.compose.material.icons.rounded.Stop
import androidx.compose.material.icons.rounded.Tune
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.IconButtonDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedIconButton
import androidx.compose.material3.Slider
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.TextField
import androidx.compose.material3.TextFieldDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.runtime.snapshotFlow
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.draw.clip
import androidx.compose.ui.geometry.CornerRadius
import androidx.compose.ui.geometry.RoundRect
import androidx.compose.ui.geometry.Size
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Outline
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.graphics.Shape
import androidx.compose.ui.unit.Density
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.LayoutDirection
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.collectLatest
import kotlinx.coroutines.launch

/** Gallery chat colors (light theme), from ui/theme/Theme.kt. */
object ChatColors {
    val userBubbleBg = Color(0xFF32628D)
    val agentBubbleBg = Color(0xFFE9EEF6)
    val taskIcon = Color(0xFF3174F1)
    val link = Color(0xFF32628D)
}

/** Port of the gallery's MessageBubbleShape: rounded bubble with one hard top corner. */
class MessageBubbleShape(
    private val radius: Dp,
    private val hardCornerAtLeftOrRight: Boolean = false,
) : Shape {
    override fun createOutline(
        size: Size,
        layoutDirection: LayoutDirection,
        density: Density,
    ): Outline {
        val radiusPx = with(density) { radius.toPx() }
        val path = Path().apply {
            addRoundRect(
                RoundRect(
                    left = 0f,
                    top = 0f,
                    right = size.width,
                    bottom = size.height,
                    topLeftCornerRadius =
                        if (hardCornerAtLeftOrRight) CornerRadius(0f, 0f)
                        else CornerRadius(radiusPx, radiusPx),
                    topRightCornerRadius =
                        if (hardCornerAtLeftOrRight) CornerRadius(radiusPx, radiusPx)
                        else CornerRadius(0f, 0f),
                    bottomLeftCornerRadius = CornerRadius(radiusPx, radiusPx),
                    bottomRightCornerRadius = CornerRadius(radiusPx, radiusPx),
                ),
            )
        }
        return Outline.Generic(path)
    }
}

@Composable
fun ChatScreen(viewModel: ChatViewModel, agentName: String) {
    val listState = rememberLazyListState()
    val scope = rememberCoroutineScope()
    val messages = viewModel.messages

    // Track whether the user is scrolled to the bottom (gallery ChatPanel logic).
    var isAtBottom by remember { mutableStateOf(true) }
    LaunchedEffect(listState) {
        snapshotFlow { !listState.canScrollForward }
            .collectLatest { rawAtBottom ->
                if (!rawAtBottom) {
                    delay(500)
                }
                isAtBottom = rawAtBottom
            }
    }

    // Auto-scroll to bottom when a new message arrives (gallery: scrollToBottom on
    // lastUserMessageIndex change).
    LaunchedEffect(messages.size) {
        if (messages.isNotEmpty()) {
            listState.animateScrollToItem(messages.size - 1)
        }
    }

    // Keep pinned to the bottom while generating and the user is at the bottom.
    LaunchedEffect(isAtBottom, viewModel.generating, messages.lastOrNull()?.text) {
        if (isAtBottom && viewModel.generating && messages.isNotEmpty()) {
            listState.scrollToItem(messages.size - 1)
        }
    }

    var showParamsDialog by remember { mutableStateOf(false) }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .imePadding(),
    ) {
        Row(
            modifier = Modifier
                .statusBarsPadding()
                .fillMaxWidth()
                .padding(horizontal = 12.dp),
            verticalAlignment = Alignment.CenterVertically,
        ) {
            Text(
                text = viewModel.status + "\nTap to switch backend (${viewModel.backendName})",
                style = MaterialTheme.typography.labelMedium,
                modifier = Modifier
                    .weight(1f)
                    .padding(vertical = 12.dp)
                    .clickable { viewModel.toggleBackend() },
            )
            IconButton(
                onClick = { viewModel.resetConversation() },
                enabled = viewModel.ready && !viewModel.generating,
            ) {
                Icon(Icons.Rounded.RestartAlt, contentDescription = "New conversation")
            }
            IconButton(
                onClick = { showParamsDialog = true },
                enabled = viewModel.ready && !viewModel.generating,
            ) {
                Icon(Icons.Rounded.Tune, contentDescription = "Parameters")
            }
        }

        Box(modifier = Modifier.weight(1f).fillMaxWidth()) {
            LazyColumn(
                state = listState,
                modifier = Modifier.fillMaxSize(),
                contentPadding = PaddingValues(vertical = 6.dp),
            ) {
                items(messages.size, key = { it }) { index ->
                    ChatMessageItem(
                        message = messages[index],
                        agentName = agentName,
                        generating = viewModel.generating && index == messages.size - 1,
                    )
                }
            }

            // Scroll-to-bottom button, shown when not at the bottom (gallery ChatView).
            if (!isAtBottom && messages.isNotEmpty()) {
                IconButton(
                    onClick = { scope.launch { listState.animateScrollToItem(messages.size - 1) } },
                    modifier = Modifier
                        .align(Alignment.BottomEnd)
                        .padding(8.dp)
                        .size(36.dp)
                        .clip(CircleShape)
                        .background(MaterialTheme.colorScheme.surfaceContainer),
                ) {
                    Icon(Icons.Rounded.KeyboardArrowDown, contentDescription = "Scroll to bottom")
                }
            }
        }

        MessageInputBar(
            ready = viewModel.ready,
            generating = viewModel.generating,
            onSend = { text ->
                viewModel.sendMessage(text)
            },
            onStop = { viewModel.stopResponse() },
        )
    }

    if (showParamsDialog) {
        ParametersDialog(
            topK = viewModel.topK,
            topP = viewModel.topP,
            temperature = viewModel.temperature,
            maxTokens = viewModel.maxTokens,
            onDismiss = { showParamsDialog = false },
            onApply = { newTopK, newTopP, newTemperature, newMaxTokens ->
                showParamsDialog = false
                viewModel.updateParameters(newTopK, newTopP, newTemperature, newMaxTokens)
            },
        )
    }
}

@Composable
private fun ParametersDialog(
    topK: Int,
    topP: Float,
    temperature: Float,
    maxTokens: Int,
    onDismiss: () -> Unit,
    onApply: (Int, Float, Float, Int) -> Unit,
) {
    var curTopK by remember { mutableStateOf(topK) }
    var curTopP by remember { mutableStateOf(topP) }
    var curTemperature by remember { mutableStateOf(temperature) }
    var curMaxTokens by remember { mutableStateOf(maxTokens) }

    AlertDialog(
        onDismissRequest = onDismiss,
        title = { Text("Parameters") },
        text = {
            Column {
                Text("Temperature (${"%.2f".format(curTemperature)})")
                Slider(value = curTemperature, onValueChange = { curTemperature = it }, valueRange = 0f..2f)
                Text("Top-K ($curTopK)")
                Slider(value = curTopK.toFloat(), onValueChange = { curTopK = it.toInt() }, valueRange = 1f..200f)
                Text("Top-P (${"%.2f".format(curTopP)})")
                Slider(value = curTopP, onValueChange = { curTopP = it }, valueRange = 0.1f..1f)
                Text("Max tokens ($curMaxTokens)")
                Slider(value = curMaxTokens.toFloat(), onValueChange = { curMaxTokens = it.toInt() }, valueRange = 256f..8192f)
            }
        },
        confirmButton = {
            TextButton(onClick = { onApply(curTopK, curTopP, curTemperature, curMaxTokens) }) {
                Text("Apply")
            }
        },
        dismissButton = {
            TextButton(onClick = onDismiss) { Text("Cancel") }
        },
    )
}

@Composable
private fun ChatMessageItem(message: ChatMessage, agentName: String, generating: Boolean) {
    val isUser = message.isUser
    Column(
        modifier = Modifier
            .fillMaxWidth()
            .padding(
                start = if (isUser) 64.dp else 16.dp,
                end = 12.dp,
                top = 6.dp,
                bottom = 6.dp,
            ),
        horizontalAlignment = if (isUser) Alignment.End else Alignment.Start,
    ) {
        Text(
            text = if (isUser) "You" else agentName,
            style = MaterialTheme.typography.titleSmall,
        )

        if (isUser) {
            Box(
                modifier = Modifier
                    .clip(MessageBubbleShape(radius = 24.dp, hardCornerAtLeftOrRight = false))
                    .background(ChatColors.userBubbleBg),
            ) {
                MarkdownText(
                    text = message.text,
                    textColor = Color.White,
                    linkColor = Color.White,
                    modifier = Modifier.padding(horizontal = 12.dp, vertical = 12.dp),
                )
            }
        } else {
            // Agent text: no bubble, like the gallery's agent response rendering.
            MarkdownText(
                text = message.text,
                modifier = Modifier.padding(vertical = 12.dp),
            )
            // Token speed while generating; latency + speed when done (gallery LatencyText).
            if (message.latencyMs >= 0) {
                Text(
                    text = "${"%.1f".format(message.tokenSpeed)} t/s · ${message.latencyMs.humanReadableDuration()}",
                    style = MaterialTheme.typography.labelSmall,
                    modifier = Modifier.alpha(0.5f),
                )
            } else if (generating && message.tokenSpeed > 0f) {
                Text(
                    text = "${"%.1f".format(message.tokenSpeed)} t/s",
                    style = MaterialTheme.typography.labelSmall,
                    modifier = Modifier.alpha(0.5f),
                )
            }
        }
    }
}

/** Port of the gallery's Float.humanReadableDuration. */
private fun Float.humanReadableDuration(): String {
    val milliseconds = this
    if (milliseconds < 1000) {
        return "$milliseconds ms"
    }
    val seconds = milliseconds / 1000f
    if (seconds < 60) {
        return "%.1f s".format(seconds)
    }
    val minutes = seconds / 60f
    return "%.1f min".format(minutes)
}

@Composable
private fun MessageInputBar(
    ready: Boolean,
    generating: Boolean,
    onSend: (String) -> Unit,
    onStop: () -> Unit,
) {
    var input by remember { mutableStateOf("") }

    Column(
        modifier = Modifier
            .fillMaxWidth()
            .navigationBarsPadding()
            .padding(horizontal = 12.dp)
            .padding(vertical = 8.dp)
            .heightIn(min = 76.dp)
            .border(
                width = 1.dp,
                color = MaterialTheme.colorScheme.outlineVariant,
                shape = RoundedCornerShape(16.dp),
            ),
    ) {
        Row(
            modifier = Modifier.fillMaxWidth(),
            verticalAlignment = Alignment.CenterVertically,
        ) {
            TextField(
                value = input,
                onValueChange = { input = it },
                modifier = Modifier.weight(1f),
                minLines = 1,
                maxLines = 3,
                colors = TextFieldDefaults.colors(
                    unfocusedContainerColor = Color.Transparent,
                    focusedContainerColor = Color.Transparent,
                    focusedIndicatorColor = Color.Transparent,
                    unfocusedIndicatorColor = Color.Transparent,
                    disabledIndicatorColor = Color.Transparent,
                    disabledContainerColor = Color.Transparent,
                ),
                textStyle = MaterialTheme.typography.bodyLarge.copy(letterSpacing = 0.2.sp),
                placeholder = { Text("Type prompt…") },
            )
        }

        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 12.dp)
                .offset(y = (-8).dp),
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.SpaceBetween,
        ) {
            OutlinedIconButton(
                onClick = {},
                border = IconButtonDefaults.outlinedIconButtonBorder(true),
            ) {
                Icon(Icons.Outlined.Add, contentDescription = "Add content")
            }

            if (generating) {
                IconButton(
                    onClick = onStop,
                    colors = IconButtonDefaults.iconButtonColors(
                        containerColor = MaterialTheme.colorScheme.secondaryContainer,
                    ),
                ) {
                    Icon(
                        Icons.Rounded.Stop,
                        contentDescription = "Stop",
                        tint = MaterialTheme.colorScheme.primary,
                    )
                }
            } else {
                IconButton(
                    onClick = {
                        onSend(input.trim())
                        input = ""
                    },
                    enabled = ready && input.isNotBlank(),
                    colors = IconButtonDefaults.iconButtonColors(
                        containerColor = ChatColors.taskIcon,
                        disabledContainerColor = ChatColors.taskIcon.copy(alpha = 0.3f),
                    ),
                ) {
                    Icon(
                        Icons.AutoMirrored.Rounded.Send,
                        contentDescription = "Send",
                        modifier = Modifier.offset(x = 2.dp),
                        tint = Color.White,
                    )
                }
            }
        }
    }
}
