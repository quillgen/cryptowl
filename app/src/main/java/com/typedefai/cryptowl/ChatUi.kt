package com.typedefai.cryptowl

import android.widget.Toast
import androidx.compose.animation.AnimatedVisibility
import androidx.compose.animation.core.FastOutSlowInEasing
import androidx.compose.animation.core.Spring
import androidx.compose.animation.core.spring
import androidx.compose.animation.core.tween
import androidx.compose.animation.expandVertically
import androidx.compose.animation.fadeIn
import androidx.compose.animation.fadeOut
import androidx.compose.animation.scaleIn
import androidx.compose.animation.shrinkVertically
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.gestures.detectTapGestures
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.imePadding
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.offset
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.material.icons.automirrored.rounded.Send
import androidx.compose.material.icons.filled.ArrowDropDown
import androidx.compose.material.icons.filled.ArrowDropUp
import androidx.compose.material.icons.outlined.Add
import androidx.compose.material.icons.outlined.ArrowDownward
import androidx.compose.material.icons.rounded.ContentCopy
import androidx.compose.material.icons.rounded.Refresh
import androidx.compose.material.icons.rounded.RestartAlt
import androidx.compose.material.icons.rounded.Stop
import androidx.compose.material.icons.rounded.Tune
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.DropdownMenu
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.IconButtonDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedIconButton
import androidx.compose.material3.SegmentedButton
import androidx.compose.material3.SegmentedButtonDefaults
import androidx.compose.material3.SingleChoiceSegmentedButtonRow
import androidx.compose.material3.Slider
import androidx.compose.material3.Switch
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.TextField
import androidx.compose.material3.TextFieldDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.derivedStateOf
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateMapOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.rememberUpdatedState
import androidx.compose.runtime.setValue
import androidx.compose.runtime.snapshotFlow
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.drawBehind
import androidx.compose.ui.geometry.CornerRadius
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.RoundRect
import androidx.compose.ui.geometry.Size
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Outline
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.graphics.Shape
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.hapticfeedback.HapticFeedbackType
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.layout.onSizeChanged
import androidx.compose.ui.platform.LocalClipboardManager
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.platform.LocalHapticFeedback
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.AnnotatedString
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.Density
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.LayoutDirection
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.typedefai.cryptowl.R
import kotlinx.coroutines.android.awaitFrame
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

/** Port of the gallery's MessageActionButton: pill with icon + label. */
@Composable
private fun MessageActionButton(
    label: String,
    icon: androidx.compose.ui.graphics.vector.ImageVector,
    enabled: Boolean,
    onClick: () -> Unit,
) {
    val alpha: Float = if (enabled) 1.0f else 0.3f
    Row(
        modifier = Modifier
            .padding(top = 4.dp)
            .clip(CircleShape)
            .background(
                if (enabled) MaterialTheme.colorScheme.secondaryContainer
                else MaterialTheme.colorScheme.surfaceContainerHigh,
            )
            .clickable(enabled = enabled) { onClick() },
        verticalAlignment = Alignment.CenterVertically,
    ) {
        Icon(
            icon,
            contentDescription = null,
            modifier = Modifier.size(16.dp).offset(x = 6.dp).alpha(alpha),
        )
        Text(
            label,
            color = MaterialTheme.colorScheme.onSecondaryContainer,
            style = MaterialTheme.typography.labelSmall,
            modifier = Modifier.padding(start = 10.dp, end = 8.dp, top = 4.dp, bottom = 4.dp).alpha(alpha),
        )
    }
}

/** Port of the gallery's MessageBodyThinking: collapsible thinking panel, auto-expanded while in progress. */
@Composable
private fun MessageBodyThinking(
    thinkingText: String,
    inProgress: Boolean,
    onCopyClicked: (String) -> Unit,
) {
    var isExpanded by remember { mutableStateOf(false) }

    // Auto-expand while thinking is in progress
    if (inProgress) {
        isExpanded = true
    }

    Column(modifier = Modifier.fillMaxWidth().padding(horizontal = 12.dp, vertical = 8.dp)) {
        Row(
            modifier = Modifier.clickable { isExpanded = !isExpanded }.padding(vertical = 4.dp),
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.spacedBy(4.dp),
        ) {
            Text(
                text = stringResource(R.string.chat_show_thinking),
                style = MaterialTheme.typography.bodyMedium,
                fontWeight = FontWeight.Medium,
            )
            Icon(
                imageVector = if (isExpanded) Icons.Filled.ArrowDropUp else Icons.Filled.ArrowDropDown,
                contentDescription = stringResource(
                    if (isExpanded) R.string.chat_hide_thinking else R.string.chat_show_thinking,
                ),
            )
        }

        AnimatedVisibility(
            visible = isExpanded,
            enter = expandVertically(),
            exit = shrinkVertically(),
        ) {
            val lineColor = MaterialTheme.colorScheme.outlineVariant
            Column(
                modifier = Modifier
                    .padding(top = 8.dp, bottom = 4.dp, start = 8.dp)
                    .drawBehind {
                        drawLine(
                            color = lineColor,
                            start = Offset(0f, 0f),
                            end = Offset(0f, size.height),
                            strokeWidth = 2.dp.toPx(),
                        )
                    }
                    .padding(start = 12.dp),
            ) {
                LongPressCopyContainer(copyText = thinkingText, onCopyClicked = onCopyClicked) {
                    MarkdownText(
                        text = thinkingText,
                        textColor = MaterialTheme.colorScheme.onSurfaceVariant,
                    )
                }
            }
        }
    }
}

/** Port of the gallery's LongPressCopyContainer: long-press opens a copy menu. */
@Composable
private fun LongPressCopyContainer(
    copyText: String,
    modifier: Modifier = Modifier,
    onCopyClicked: (String) -> Unit = {},
    content: @Composable () -> Unit,
) {
    var showMenu by remember { mutableStateOf(false) }
    val haptic = LocalHapticFeedback.current
    Box(
        modifier = modifier
            .pointerInput(Unit) {
                detectTapGestures(
                    onLongPress = {
                        haptic.performHapticFeedback(HapticFeedbackType.LongPress)
                        showMenu = true
                    },
                )
            },
    ) {
        content()
        DropdownMenu(
            expanded = showMenu,
            onDismissRequest = { showMenu = false },
            shape = RoundedCornerShape(24.dp),
            tonalElevation = 8.dp,
            shadowElevation = 8.dp,
        ) {
            DropdownMenuItem(
                text = {
                    Text(
                        stringResource(R.string.chat_copy),
                        style = MaterialTheme.typography.bodyMedium.copy(
                            color = MaterialTheme.colorScheme.onSurface,
                        ),
                    )
                },
                leadingIcon = {
                    Icon(
                        Icons.Rounded.ContentCopy,
                        contentDescription = stringResource(R.string.chat_copy),
                        modifier = Modifier.size(18.dp),
                        tint = MaterialTheme.colorScheme.onSurfaceVariant,
                    )
                },
                onClick = {
                    showMenu = false
                    onCopyClicked(copyText)
                },
            )
        }
    }
}

/** Port of the gallery's scrollToBottom: scroll to the absolute end (ScrollState.maxValue). */
private const val SCROLL_ANIMATION_DURATION_MS = 300

private suspend fun scrollToBottom(
    listState: androidx.compose.foundation.ScrollState,
    animate: Boolean = false,
    animationDurationMs: Int = SCROLL_ANIMATION_DURATION_MS,
) {
    if (animate) {
        listState.animateScrollTo(
            listState.maxValue,
            animationSpec = tween(durationMillis = animationDurationMs, easing = FastOutSlowInEasing),
        )
    } else {
        listState.scrollTo(listState.maxValue)
    }
}

/** Port of the gallery's ScrollToBottomButton: filled circle, outlined down arrow, bouncy fade/scale. */
@Composable
private fun ScrollToBottomButton(isAtBottom: Boolean, onClick: () -> Unit) {
    AnimatedVisibility(
        visible = !isAtBottom,
        enter =
            fadeIn(animationSpec = tween(durationMillis = 300)) +
                scaleIn(
                    animationSpec =
                        spring(
                            dampingRatio = Spring.DampingRatioMediumBouncy,
                            stiffness = Spring.StiffnessMedium,
                        ),
                ),
        exit = fadeOut(animationSpec = tween(durationMillis = 200)),
    ) {
        IconButton(
            onClick = onClick,
            colors = IconButtonDefaults.filledIconButtonColors(
                containerColor = MaterialTheme.colorScheme.secondaryContainer,
            ),
        ) {
            Icon(
                imageVector = Icons.Outlined.ArrowDownward,
                contentDescription = stringResource(R.string.chat_scroll_to_bottom),
                tint = MaterialTheme.colorScheme.onSecondaryContainer,
            )
        }
    }
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
fun ChatScreen(viewModel: ChatViewModel, agentName: String, onBack: (() -> Unit)? = null) {
    val listState = rememberScrollState()
    val scope = rememberCoroutineScope()
    val messages = viewModel.messages

    // Stores the heights of the items in the list, indexed by the item index (gallery ChatPanel).
    val itemHeights = remember { mutableStateMapOf<Int, Int>() }

    // Stores the height of the viewport in pixels.
    var viewportHeightPx by remember { mutableIntStateOf(0) }

    // Turn messages into a derived state to trigger updates when the list is updated.
    val currentMessages by rememberUpdatedState(messages)

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

    // Stores the index of the last user message as a derived state.
    val lastUserMessageIndex by remember(currentMessages) {
        derivedStateOf {
            currentMessages.indexOfLast { it.isUser }
        }
    }

    // Stores the dynamic bottom padding required to push the last user message to the top edge
    // of the view, so the streaming response is always visible without per-token scrolling.
    val density = LocalDensity.current
    val dynamicBottomPadding by remember {
        derivedStateOf {
            if (lastUserMessageIndex == -1 || viewportHeightPx == 0) return@derivedStateOf 0.dp

            var bottomContentHeight = 0
            for (i in lastUserMessageIndex until currentMessages.size) {
                bottomContentHeight += itemHeights[i] ?: 0
            }

            // The padding required to push the last user message to the top.
            val paddingPx = maxOf(0, viewportHeightPx - bottomContentHeight)
            with(density) { paddingPx.toDp() }
        }
    }

    // Scroll to the bottom when the last user message index changes (i.e. when a new user prompt
    // is sent), like the gallery: await a frame for layout, then animate to the bottom.
    LaunchedEffect(lastUserMessageIndex) {
        if (lastUserMessageIndex != -1) {
            val unused = awaitFrame()
            scrollToBottom(
                listState = listState,
                animate = true,
                animationDurationMs = SCROLL_ANIMATION_DURATION_MS * 2,
            )
        }
    }

    var showParamsDialog by remember { mutableStateOf(false) }
    val copyHandler = rememberCopyHandler()

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
            if (onBack != null) {
                IconButton(onClick = onBack) {
                    Icon(
                        Icons.AutoMirrored.Filled.ArrowBack,
                        contentDescription = stringResource(R.string.chat_back),
                    )
                }
            }
            Text(
                text = viewModel.status,
                style = MaterialTheme.typography.labelMedium,
                modifier = Modifier
                    .weight(1f)
                    .padding(vertical = 12.dp),
            )
            IconButton(
                onClick = { viewModel.resetConversation() },
                enabled = viewModel.ready && !viewModel.generating,
            ) {
                Icon(Icons.Rounded.RestartAlt, contentDescription = stringResource(R.string.chat_new_conversation))
            }
            IconButton(
                onClick = { showParamsDialog = true },
                enabled = viewModel.ready && !viewModel.generating,
            ) {
                Icon(Icons.Rounded.Tune, contentDescription = stringResource(R.string.chat_parameters))
            }
        }

        Box(
            modifier = Modifier
                .weight(1f)
                .fillMaxWidth()
                .onSizeChanged { viewportHeightPx = it.height },
        ) {
            Column(
                modifier = Modifier
                    .fillMaxSize()
                    .verticalScroll(listState),
                verticalArrangement = Arrangement.Top,
            ) {
                messages.forEachIndexed { index, message ->
                    ChatMessageItem(
                        message = message,
                        agentName = agentName,
                        generating = viewModel.generating && index == messages.size - 1,
                        onRunAgain = { viewModel.runAgain(it) },
                        onCopy = copyHandler,
                        modifier = Modifier
                            .fillMaxWidth()
                            .onSizeChanged { size ->
                                if (itemHeights[index] != size.height) {
                                    itemHeights[index] = size.height
                                }
                            },
                    )
                }

                // The spacer at the bottom to push the content up so that the last user message
                // will be positioned at the top edge of the view when the list is scrolled to the
                // bottom (gallery dynamicBottomPadding).
                Spacer(modifier = Modifier.height(dynamicBottomPadding).fillMaxWidth())
            }

            // "Scroll to bottom" button, only shown when the list is not at the bottom
            // (gallery ChatPanel: centered horizontally at the bottom).
            Column(
                modifier = Modifier
                    .align(Alignment.BottomCenter)
                    .fillMaxWidth()
                    .padding(bottom = 4.dp),
                horizontalAlignment = Alignment.CenterHorizontally,
            ) {
                ScrollToBottomButton(isAtBottom = isAtBottom) {
                    scope.launch { scrollToBottom(listState, animate = true) }
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
            thinking = viewModel.thinking,
            speculativeDecoding = viewModel.speculativeDecoding,
            accelerator = viewModel.accelerator,
            onDismiss = { showParamsDialog = false },
            onApply = { newTopK, newTopP, newTemperature, newMaxTokens, newAccelerator, newThinking, newSpecDec ->
                showParamsDialog = false
                viewModel.updateSettings(newTopK, newTopP, newTemperature, newMaxTokens, newAccelerator, newThinking, newSpecDec)
            },
        )
    }
}

/** Copies text to the clipboard with a toast (gallery copyToClipboard). */
@Composable
private fun rememberCopyHandler(): (String) -> Unit {
    val clipboard = LocalClipboardManager.current
    val copied = stringResource(R.string.chat_copied)
    val context = LocalContext.current
    return { text ->
        clipboard.setText(AnnotatedString(text))
        Toast.makeText(context, copied, Toast.LENGTH_SHORT).show()
    }
}

@Composable
private fun ParametersDialog(
    topK: Int,
    topP: Float,
    temperature: Float,
    maxTokens: Int,
    thinking: Boolean,
    speculativeDecoding: Boolean,
    accelerator: String,
    onDismiss: () -> Unit,
    onApply: (Int, Float, Float, Int, String, Boolean, Boolean) -> Unit,
) {
    var curTopK by remember { mutableStateOf(topK) }
    var curTopP by remember { mutableStateOf(topP) }
    var curTemperature by remember { mutableStateOf(temperature) }
    var curMaxTokens by remember { mutableStateOf(maxTokens) }
    var curThinking by remember { mutableStateOf(thinking) }
    var curSpeculativeDecoding by remember { mutableStateOf(speculativeDecoding) }
    var curAccelerator by remember { mutableStateOf(accelerator) }

    AlertDialog(
        onDismissRequest = onDismiss,
        title = { Text(stringResource(R.string.chat_parameters)) },
        text = {
            Column {
                // Max tokens: gallery NumberSliderConfig(2000..maxContextLength=32000, default 4000).
                Text(stringResource(R.string.chat_max_tokens), style = MaterialTheme.typography.titleSmall)
                Slider(
                    value = curMaxTokens.toFloat(),
                    onValueChange = { curMaxTokens = it.toInt() },
                    valueRange = 2000f..32000f,
                )
                // Top-K: gallery NumberSliderConfig(1..100, default 64).
                Text(stringResource(R.string.chat_top_k), style = MaterialTheme.typography.titleSmall)
                Slider(
                    value = curTopK.toFloat(),
                    onValueChange = { curTopK = it.toInt() },
                    valueRange = 1f..100f,
                )
                // Top-P: gallery NumberSliderConfig(0..1, default 0.95).
                Text(stringResource(R.string.chat_top_p), style = MaterialTheme.typography.titleSmall)
                Slider(
                    value = curTopP,
                    onValueChange = { curTopP = it },
                    valueRange = 0f..1f,
                )
                // Temperature: gallery NumberSliderConfig(0..2, default 1.0).
                Text(stringResource(R.string.chat_temperature), style = MaterialTheme.typography.titleSmall)
                Slider(
                    value = curTemperature,
                    onValueChange = { curTemperature = it },
                    valueRange = 0f..2f,
                )
                // Accelerator: gallery SegmentedButtonConfig (gpu/cpu).
                Text(stringResource(R.string.chat_accelerator), style = MaterialTheme.typography.titleSmall)
                SingleChoiceSegmentedButtonRow(
                    modifier = Modifier.fillMaxWidth(),
                ) {
                    listOf("gpu", "cpu").forEachIndexed { index, label ->
                        SegmentedButton(
                            shape = SegmentedButtonDefaults.itemShape(index = index, count = 2),
                            selected = curAccelerator == label,
                            onClick = { curAccelerator = label },
                        ) {
                            Text(label.uppercase())
                        }
                    }
                }
                // Thinking: gallery BooleanSwitchConfig (Gemma 4 supports it).
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.SpaceBetween,
                ) {
                    Text(stringResource(R.string.chat_enable_thinking), style = MaterialTheme.typography.titleSmall)
                    Switch(checked = curThinking, onCheckedChange = { curThinking = it })
                }
                // Speculative decoding / MTP: gallery BooleanSwitchConfig.
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.SpaceBetween,
                ) {
                    Text(stringResource(R.string.chat_enable_speculative), style = MaterialTheme.typography.titleSmall)
                    Switch(checked = curSpeculativeDecoding, onCheckedChange = { curSpeculativeDecoding = it })
                }
            }
        },
        confirmButton = {
            TextButton(onClick = {
                onApply(curTopK, curTopP, curTemperature, curMaxTokens, curAccelerator, curThinking, curSpeculativeDecoding)
            }) {
                Text(stringResource(R.string.chat_apply))
            }
        },
        dismissButton = {
            TextButton(onClick = onDismiss) { Text(stringResource(R.string.chat_cancel)) }
        },
    )
}

@Composable
private fun ChatMessageItem(
    message: ChatMessage,
    agentName: String,
    generating: Boolean,
    onRunAgain: (String) -> Unit,
    onCopy: (String) -> Unit,
    modifier: Modifier = Modifier,
) {
    val isUser = message.isUser
    Column(
        modifier = modifier.padding(
            start = if (isUser) 64.dp else 16.dp,
            end = 12.dp,
            top = 6.dp,
            bottom = 6.dp,
        ),
        horizontalAlignment = if (isUser) Alignment.End else Alignment.Start,
    ) {
        Text(
            text = if (isUser) stringResource(R.string.chat_you) else agentName,
            style = MaterialTheme.typography.titleSmall,
        )

        if (isUser) {
            LongPressCopyContainer(copyText = message.text) {
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
            }
            // Run again button (gallery MessageActionButton on user messages).
            MessageActionButton(
                label = stringResource(R.string.chat_run_again),
                icon = Icons.Rounded.Refresh,
                enabled = !generating,
                onClick = { onRunAgain(message.text) },
            )
        } else {
            // Agent text: no bubble, like the gallery's agent response rendering.
            LongPressCopyContainer(copyText = message.text) {
                Column {
                    // Thinking panel (gallery MessageBodyThinking above the response).
                    if (message.thinkingText.isNotEmpty()) {
                        MessageBodyThinking(
                            thinkingText = message.thinkingText,
                            inProgress = generating,
                            onCopyClicked = { onCopy(it) },
                        )
                    }
                    MarkdownText(
                        text = message.text,
                        modifier = Modifier.padding(vertical = 12.dp),
                    )
                }
            }
            // Latency + copy row (gallery ChatPanel agent message actions).
            Row(
                verticalAlignment = Alignment.CenterVertically,
                horizontalArrangement = Arrangement.spacedBy(8.dp),
            ) {
                LatencyText(message = message)
                if (!generating && message.text.isNotEmpty()) {
                    IconButton(
                        onClick = { onCopy(message.text) },
                        modifier = Modifier.size(28.dp),
                    ) {
                        Icon(
                            imageVector = Icons.Rounded.ContentCopy,
                            contentDescription = stringResource(R.string.chat_copy),
                            tint = MaterialTheme.colorScheme.onSurfaceVariant.copy(alpha = 0.6f),
                            modifier = Modifier.size(18.dp),
                        )
                    }
                }
            }
        }
    }
}

/** Port of the gallery's LatencyText. */
@Composable
private fun LatencyText(message: ChatMessage) {
    if (message.latencyMs >= 0) {
        Text(
            "${"%.1f".format(message.tokenSpeed)} t/s · ${message.latencyMs.humanReadableDuration()}",
            modifier = Modifier.alpha(0.5f),
            style = MaterialTheme.typography.labelSmall,
        )
    } else if (message.tokenSpeed > 0f) {
        Text(
            "${"%.1f".format(message.tokenSpeed)} t/s",
            modifier = Modifier.alpha(0.5f),
            style = MaterialTheme.typography.labelSmall,
        )
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
                placeholder = { Text(stringResource(R.string.chat_type_prompt)) },
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
                Icon(Icons.Outlined.Add, contentDescription = stringResource(R.string.chat_add_content))
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
                        contentDescription = stringResource(R.string.chat_stop),
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
                        contentDescription = stringResource(R.string.chat_send),
                        modifier = Modifier.offset(x = 2.dp),
                        tint = Color.White,
                    )
                }
            }
        }
    }
}
