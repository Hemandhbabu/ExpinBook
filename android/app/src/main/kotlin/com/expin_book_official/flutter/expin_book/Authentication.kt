package com.expin_book_official.flutter.expin_book

import android.content.Context

import androidx.biometric.BiometricManager
import androidx.biometric.BiometricPrompt
import androidx.fragment.app.FragmentActivity

import java.util.concurrent.Executor

object Authentication {
    fun showAuthenticationDialog(
        activity: FragmentActivity,
        listener: AuthenticationListener
    ) {
        val executor: Executor = AppExecutors.instance.mainThread()
        val biometricPrompt = BiometricPrompt(activity,
            executor, object : BiometricPrompt.AuthenticationCallback() {
                override fun onAuthenticationError(
                    errorCode: Int,
                    errString: CharSequence
                ) {
                    super.onAuthenticationError(errorCode, errString)
                    if (errString != "Cancel") {
                        listener.onError(errString as String)
                    }
                }

                override fun onAuthenticationSucceeded(
                    result: BiometricPrompt.AuthenticationResult
                ) {
                    super.onAuthenticationSucceeded(result)
                    listener.onSuccess()
                }
            })
        val promptInfo: BiometricPrompt.PromptInfo = BiometricPrompt.PromptInfo.Builder()
            .setTitle("Verify your biometrics")
            .setNegativeButtonText("Cancel")
            .setAllowedAuthenticators(BiometricManager.Authenticators.BIOMETRIC_STRONG)
            .build()
        biometricPrompt.authenticate(promptInfo)
    }

    fun canAuth(context: Context): Boolean {
        val biometricManager: BiometricManager = BiometricManager.from(context)
        var message = false
        when (biometricManager.canAuthenticate(BiometricManager.Authenticators.BIOMETRIC_STRONG)) {
            BiometricManager.BIOMETRIC_SUCCESS -> message = true
            BiometricManager.BIOMETRIC_ERROR_HW_UNAVAILABLE, BiometricManager.BIOMETRIC_ERROR_NONE_ENROLLED, BiometricManager.BIOMETRIC_ERROR_NO_HARDWARE, BiometricManager.BIOMETRIC_ERROR_SECURITY_UPDATE_REQUIRED, BiometricManager.BIOMETRIC_ERROR_UNSUPPORTED, BiometricManager.BIOMETRIC_STATUS_UNKNOWN -> {}
        }
        return message
    }

    fun checkBiometricsStatus(context: Context): String? {
        val biometricManager: BiometricManager = BiometricManager.from(context)
        var message: String? = null
        when (biometricManager.canAuthenticate(BiometricManager.Authenticators.BIOMETRIC_STRONG)) {
            BiometricManager.BIOMETRIC_SUCCESS -> message = "Success"
            BiometricManager.BIOMETRIC_ERROR_HW_UNAVAILABLE, BiometricManager.BIOMETRIC_ERROR_NO_HARDWARE, BiometricManager.BIOMETRIC_ERROR_SECURITY_UPDATE_REQUIRED -> message =
                "Biometric hardware unavailable"
            BiometricManager.BIOMETRIC_ERROR_NONE_ENROLLED -> message =
                "No biometric credential is enrolled"
            BiometricManager.BIOMETRIC_ERROR_UNSUPPORTED -> message =
                "Biometric authentication unsupported"
            BiometricManager.BIOMETRIC_STATUS_UNKNOWN -> message = "Unknown"
        }
        return message
    }

    interface AuthenticationListener {
        fun onSuccess()
        fun onError(error: String?)
    }
}