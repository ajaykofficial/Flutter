import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothManager {
  static final BluetoothManager _instance = BluetoothManager._internal();

  factory BluetoothManager() {
    return _instance;
  }

  BluetoothManager._internal();

  final FlutterBluePlus _flutterBlue = FlutterBluePlus();
  BluetoothDevice? _connectedDevice;

  BluetoothDevice? get connectedDevice => _connectedDevice;

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      _connectedDevice = device;
    } catch (e) {
      print("Error connecting to device: $e");
    }
  }

  Future<void> disconnectDevice() async {
    if (_connectedDevice != null) {
      await _connectedDevice!.disconnect();
      _connectedDevice = null;
    }
  }

  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;
  void startScan() => FlutterBluePlus.startScan();
  void stopScan() => FlutterBluePlus.stopScan();
}
