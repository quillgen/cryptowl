package com.riguz.cryptowl

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
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.rounded.Send
import androidx.compose.material.icons.outlined.Add
import androidx.compose.material.icons.rounded.Stop
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.IconButtonDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedIconButton
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.material3.TextFieldDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
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
    val messages = viewModel.messages

    LaunchedEffect(messages.size) {
        if (messages.isNotEmpty()) {
            listState.scrollToItem(messages.size - 1)
        }
    }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .imePadding(),
    ) {
        Text(
            text = viewModel.status + "\nTap to switch backend (${viewModel.backendName})",
            style = MaterialTheme.typography.labelMedium,
            modifier = Modifier
                .statusBarsPadding()
                .padding(12.dp)
                .clickable { viewModel.toggleBackend() },
        )

        LazyColumn(
            state = listState,
            modifier = Modifier
                .weight(1f)
                .fillMaxWidth(),
            contentPadding = PaddingValues(vertical = 6.dp),
        ) {
            items(messages.size, key = { it }) { index ->
                ChatMessageItem(message = messages[index], agentName = agentName)
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
}

@Composable
private fun ChatMessageItem(message: ChatMessage, agentName: String) {
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
        }
    }
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
