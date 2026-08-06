package com.typedefai.cryptowl

import android.app.Application
import androidx.biometric.BiometricManager
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.viewModelScope
import com.typedefai.cryptowl.crypto.ProtectedValue
import com.typedefai.cryptowl.vault.BioKeySetup
import com.typedefai.cryptowl.vault.DeviceSecretStore
import com.typedefai.cryptowl.vault.VaultCreator
import com.typedefai.cryptowl.vault.VaultMeta
import com.typedefai.cryptowl.vault.VaultStore
import java.util.concurrent.atomic.AtomicReference
import javax.crypto.Cipher
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

sealed interface AppScreen {
    data object Loading : AppScreen
    data object Intro : AppScreen
    data object PasswordSetup : AppScreen
    data object BiometricSetup : AppScreen
    data object Home : AppScreen
}

class MainViewModel(app: Application) : AndroidViewModel(app) {

    private val _screen = MutableStateFlow<AppScreen>(AppScreen.Loading)
    val screen: StateFlow<AppScreen> = _screen.asStateFlow()

    private val _creatingVault = MutableStateFlow(false)
    val creatingVault: StateFlow<Boolean> = _creatingVault.asStateFlow()

    private val _vaultError = MutableStateFlow<String?>(null)
    val vaultError: StateFlow<String?> = _vaultError.asStateFlow()

    private val _biometricReady = MutableStateFlow(false)
    val biometricReady: StateFlow<Boolean> = _biometricReady.asStateFlow()

    private val _biometricCipher = MutableStateFlow<Cipher?>(null)
    val biometricCipher: StateFlow<Cipher?> = _biometricCipher.asStateFlow()

    private val _biometricError = MutableStateFlow<String?>(null)
    val biometricError: StateFlow<String?> = _biometricError.asStateFlow()

    private val masterPassword = AtomicReference<ProtectedValue?>(null)
    private val preparedBiometric = AtomicReference<BioKeySetup.Prepared?>(null)

    private val vaultId = VaultStore.DEFAULT_VAULT_ID

    init {
        val onboarded = DeviceSecretStore.exists(getApplication()) && VaultStore.isOnboarded(getApplication())
        _screen.value = if (onboarded) AppScreen.Home else AppScreen.Intro
    }

    fun startOnboarding() {
        _screen.value = AppScreen.PasswordSetup
    }

    fun createVault(password: ProtectedValue) {
        _creatingVault.value = true
        _vaultError.value = null
        viewModelScope.launch {
            try {
                withContext(Dispatchers.IO) {
                    VaultCreator(getApplication()).create(password)
                }
                masterPassword.set(password)
                _screen.value = AppScreen.BiometricSetup
            } catch (e: Exception) {
                _vaultError.value = e.message ?: "Failed to create the vault"
            } finally {
                _creatingVault.value = false
            }
        }
    }

    /** Prepares the biometric wrap (derives VaultKey, creates BioKey encrypt cipher). */
    fun prepareBiometric() {
        val password = masterPassword.get() ?: run {
            _biometricError.value = "Master password no longer available"
            return
        }
        if (BiometricManager.from(getApplication()).canAuthenticate(BiometricManager.Authenticators.BIOMETRIC_STRONG)
            != BiometricManager.BIOMETRIC_SUCCESS
        ) {
            _biometricError.value = "No strong biometrics enrolled on this device"
            return
        }
        viewModelScope.launch {
            try {
                val prepared = withContext(Dispatchers.IO) {
                    BioKeySetup(getApplication()).prepare(password, vaultId)
                }
                preparedBiometric.getAndSet(prepared)?.let { BioKeySetup(getApplication()).cancel(it) }
                _biometricCipher.value = prepared.cipher
                _biometricReady.value = true
            } catch (e: Exception) {
                _biometricError.value = e.message ?: "Fingerprint setup failed"
            }
        }
    }

    /** Completes the wrap with the biometric-authorized cipher. */
    fun completeBiometric(cipher: Cipher) {
        val prepared = preparedBiometric.get() ?: return
        viewModelScope.launch {
            try {
                withContext(Dispatchers.IO) {
                    BioKeySetup(getApplication()).complete(prepared, cipher)
                }
                finishOnboarding()
            } catch (e: Exception) {
                _biometricError.value = e.message ?: "Fingerprint setup failed"
            } finally {
                preparedBiometric.set(null)
                _biometricCipher.value = null
                _biometricReady.value = false
            }
        }
    }

    /** Prompt was canceled/errored: wipe the prepared keys but stay on the screen. */
    fun cancelBiometricPrompt() {
        preparedBiometric.getAndSet(null)?.let { BioKeySetup(getApplication()).cancel(it) }
        _biometricCipher.value = null
        _biometricReady.value = false
    }

    /** User chose to skip fingerprint setup entirely. */
    fun skipBiometric() {
        cancelBiometricPrompt()
        finishOnboarding()
    }

    private fun finishOnboarding() {
        masterPassword.getAndSet(null)?.clear()
        _screen.value = AppScreen.Home
    }
}
