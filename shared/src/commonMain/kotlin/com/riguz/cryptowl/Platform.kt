package com.riguz.cryptowl

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform