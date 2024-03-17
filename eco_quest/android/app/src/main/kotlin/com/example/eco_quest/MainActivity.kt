package com.example.eco_quest

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.bluetooth.BluetoothAdapter

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.eco_quest/bluetooth"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "checkBluetoothStatus" -> {
                    // Implement logic to check Bluetooth status here
                    val bluetoothAdapter = BluetoothAdapter.getDefaultAdapter()
                    val isBluetoothEnabled = bluetoothAdapter?.isEnabled ?: false
                    result.success(isBluetoothEnabled)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
