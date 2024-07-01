import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothManager extends ChangeNotifier {
  static final BluetoothManager _instance = BluetoothManager._internal();

  factory BluetoothManager() {
    return _instance;
  }

  BluetoothManager._internal();

  BluetoothDevice? _connectedDevice;

  BluetoothDevice? get connectedDevice => _connectedDevice;

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      _connectedDevice = device;
      notifyListeners(); // Notify listeners about the connection state change
    } catch (e) {
      print("Error connecting to device: $e");
    }
  }

  Future<void> disconnectDevice() async {
    if (_connectedDevice != null) {
      await _connectedDevice!.disconnect();
      _connectedDevice = null;
      notifyListeners(); // Notify listeners about the connection state change
    }
  }

  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;
  void startScan() => FlutterBluePlus.startScan();
  void stopScan() => FlutterBluePlus.stopScan();
}
