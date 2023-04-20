package com.expin_book_official.flutter.expin_book

import android.os.Build
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.time.ZoneId
import java.util.TimeZone

class MainActivity : FlutterFragmentActivity() {
    companion object {
        const val NATIVE_CHANNEL = "com.expin_book_official.flutter.expin_book/native"
        const val AUTH_CHANNEL = "com.expin_book_official.flutter.expin_book/auth"
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            NATIVE_CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "android_version" -> result.success(Build.VERSION.SDK_INT)
                "getLocalTimezone" -> {
                    val zone = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                         ZoneId.systemDefault().id
                    }else{
                        TimeZone.getDefault().id
                    }
                    result.success(zone)
                }
            }
        }
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            AUTH_CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "authenticate" -> Authentication.showAuthenticationDialog(
                    this,
                    object : Authentication.AuthenticationListener{
                        override fun onSuccess() {
                            result.success(true)
                        }

                        override fun onError(error: String?) {
                            result.error("Auth error",error,null)
                        }

                    }
                )
                "canAuth" -> {
                    val canAuth = Authentication.canAuth(this)
                    val status = Authentication.checkBiometricsStatus(this)
                    val map = hashMapOf("canAuth" to canAuth,"checkBiometrics" to status)
                    result.success(map)
                }
            }
        }
    }
}
