package com.riguz.cryptowl

import android.view.Gravity
import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.FrameLayout
import androidx.recyclerview.widget.RecyclerView
import com.riguz.cryptowl.databinding.ItemChatMessageBinding

data class ChatMessage(val isUser: Boolean, var text: String)

class ChatAdapter : RecyclerView.Adapter<ChatAdapter.MessageViewHolder>() {

    private val messages = mutableListOf<ChatMessage>()

    fun add(message: ChatMessage): ChatMessage {
        messages.add(message)
        notifyItemInserted(messages.size - 1)
        return message
    }

    fun lastChanged() {
        if (messages.isNotEmpty()) {
            notifyItemChanged(messages.size - 1)
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MessageViewHolder {
        val binding = ItemChatMessageBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return MessageViewHolder(binding)
    }

    override fun onBindViewHolder(holder: MessageViewHolder, position: Int) {
        val message = messages[position]
        val bubble = holder.binding.textMessage
        bubble.text = message.text
        bubble.setBackgroundResource(if (message.isUser) R.drawable.bg_bubble_user else R.drawable.bg_bubble_ai)
        val params = bubble.layoutParams as FrameLayout.LayoutParams
        params.gravity = if (message.isUser) Gravity.END else Gravity.START
        bubble.layoutParams = params
    }

    override fun getItemCount(): Int = messages.size

    class MessageViewHolder(val binding: ItemChatMessageBinding) :
        RecyclerView.ViewHolder(binding.root)
}
