package com.example.ai_upi_analyzer

import android.provider.Telephony
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "ai_upi_analyzer/sms"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->

            when (call.method) {

                "testChannel" -> {
                    result.success("Android channel working")
                }

                "getSmsMessages" -> {

                    try {

                        val messages = mutableListOf<String>()

                        val cursor = contentResolver.query(
                            Telephony.Sms.Inbox.CONTENT_URI,
                            null,
                            null,
                            null,
                            Telephony.Sms.DEFAULT_SORT_ORDER
                        )

                        cursor?.use {

                            val bodyIndex =
                                it.getColumnIndex(Telephony.Sms.BODY)

                            while (it.moveToNext()) {

                                messages.add(
                                    it.getString(bodyIndex)
                                )

                                if (messages.size >= 100) {
                                    break
                                }
                            }
                        }

                        result.success(messages)

                    } catch (e: Exception) {

                        result.error(
                            "SMS_ERROR",
                            e.message,
                            null
                        )
                    }
                }

                else -> result.notImplemented()
            }
        }
    }
}