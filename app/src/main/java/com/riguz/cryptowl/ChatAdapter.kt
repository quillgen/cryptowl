package com.riguz.cryptowl

import android.graphics.Color
import android.view.Gravity
import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.LinearLayout
import android.widget.TextView
import androidx.core.content.ContextCompat
import androidx.recyclerview.widget.RecyclerView
import com.riguz.cryptowl.databinding.ItemChatMessageBinding

data class ChatMessage(val isUser: Boolean, var text: String)

/**
 * Gallery-style chat: user messages are right-aligned blue bubbles with a
 * "You" label; agent messages are left-aligned plain text under a model label.
 */
class ChatAdapter(
    private val agentName: String,
) : RecyclerView.Adapter<ChatAdapter.MessageViewHolder>() {

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
        holder.bind(message, agentName)
    }

    override fun getItemCount(): Int = messages.size

    class MessageViewHolder(
        val binding: ItemChatMessageBinding,
    ) : RecyclerView.ViewHolder(binding.root) {

        fun bind(message: ChatMessage, agentName: String) {
            binding.textSender.text = if (message.isUser) "You" else agentName
            binding.textMessage.text = message.text

            val context = binding.root.context
            val gravity = if (message.isUser) Gravity.END else Gravity.START
            setChildGravity(binding.textSender, gravity)
            setChildGravity(binding.textMessage, gravity)

            if (message.isUser) {
                binding.textMessage.setBackgroundResource(R.drawable.bg_bubble_user)
                binding.textMessage.setTextColor(Color.WHITE)
            } else {
                binding.textMessage.setBackgroundResource(0)
                binding.textMessage.setTextColor(ContextCompat.getColor(context, R.color.agent_text))
            }
        }

        private fun setChildGravity(view: TextView, gravity: Int) {
            val params = view.layoutParams as LinearLayout.LayoutParams
            params.gravity = gravity
            view.layoutParams = params
        }
    }
}
