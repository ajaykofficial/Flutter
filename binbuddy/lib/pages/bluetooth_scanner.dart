import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothDevices extends StatelessWidget {
  const BluetoothDevices({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.limeAccent,
        centerTitle: true,
        title: const Text(
          'Bluetooth Devices',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Norican-Regular',
              fontSize: 30),
        ),
        actions: <Widget>[
          Consumer<BluetoothDevicesModel>(
            builder: (context, model, child) => IconButton(
              icon: const Icon(Icons.refresh),
              onPressed:
                  model.isScanning ? null : () => model.startScanning(context),
            ),
          ),
        ],
      ),
      body: Stack(children: [
        Positioned(
          top: 40,
          left: 20,
          right: 20,
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.greenAccent, Colors.blueAccent],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'Bin Buddy',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Norican-Regular'),
              ),
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "assets/images/scbg.jpg"), // Your background image path
              fit: BoxFit.cover,
            ),
          ),
          child: Consumer<BluetoothDevicesModel>(
            builder: (context, model, child) {
              return model.isScanning
                  ? const Center(child: CircularProgressIndicator())
                  : model.devices.isEmpty
                      ? Center(
                          child: GestureDetector(
                            onTap: model.isScanning
                                ? null
                                : () => model.startScanning(context),
                            child: const Card(
                              color: Colors.limeAccent,
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'No devices found🤔',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () => model.startScanning(context),
                          child: ListView.builder(
                            itemCount: model.devices.length,
                            itemBuilder: (context, index) {
                              final device = model.devices[index].device;
                              // final rssi = model.devices[index].rssi;
                              return Card(
                                // shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(50)),
                                elevation: 4,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: ListTile(
                                  leading: const Icon(Icons.bluetooth,
                                      color: Colors.blue),
                                  title: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Text(
                                      device.platformName.isNotEmpty
                                          ? device.platformName
                                          : 'Unknown Device',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  // subtitle: Column(
                                  //   crossAxisAlignment:
                                  //       CrossAxisAlignment.start,
                                  //   children: <Widget>[
                                  //     Text('Signal strength: $rssi dBm'),
                                  //     Text(
                                  //         'Device ID: ${device.remoteId.toString()}'),
                                  //   ],
                                  // ),
                                  trailing:
                                      _buildConnectionButton(device, model),
                                ),
                              );
                            },
                          ),
                        );
            },
          ),
        ),
      ]),
    );
  }

  Widget _buildConnectionButton(
      BluetoothDevice device, BluetoothDevicesModel model) {
    return StreamBuilder<BluetoothConnectionState>(
      stream: device.connectionState,
      initialData: BluetoothConnectionState.disconnected,
      builder: (context, snapshot) {
        final isConnected = snapshot.data == BluetoothConnectionState.connected;
        return ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                isConnected ? Colors.redAccent : Colors.greenAccent),
          ),
          onPressed: () async {
            if (isConnected) {
              await _disconnectDevice(device, model);
            } else {
              await _connectDevice(device, model);
            }
          },
          child: Text(isConnected ? 'Disconnect' : 'Connect'),
        );
      },
    );
  }

  Future<void> _connectDevice(
      BluetoothDevice device, BluetoothDevicesModel model) async {
    try {
      await device.connect();
      ScaffoldMessenger.of(model.context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text('Connected to ${device.platformName}'),
        ),
      );
      model.handleDisconnection(device);
      model.connectedDevice = device;
    } catch (e) {
      print('Failed to connect: $e');
    }
  }

  Future<void> _disconnectDevice(
      BluetoothDevice device, BluetoothDevicesModel model) async {
    try {
      await device.disconnect();
      ScaffoldMessenger.of(model.context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text('Disconnected from ${device.platformName}'),
        ),
      );
      model.connectedDevice = null;
    } catch (e) {
      print('Failed to disconnect: $e');
    }
  }
}

class BluetoothDevicesModel extends ChangeNotifier {
  final FlutterBluePlus flutterBlue = FlutterBluePlus();
  List<ScanResult> devices = [];
  bool isScanning = false;
  BluetoothDevice? connectedDevice;
  late BuildContext context;

  static const int maxRetries = 5;
  static const Duration initialDelay = Duration(seconds: 2);

  Future<void> startScanning(BuildContext context) async {
    this.context = context;
    if (await _checkPermissions(context) &&
        await _isBluetoothEnabled(context)) {
      _scanForDevices();
    }
  }

  Future<bool> _checkPermissions(BuildContext context) async {
    // Check and request all necessary permissions
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
    ].request();

    // Check if all permissions are granted
    bool allGranted = statuses.values.every((status) => status.isGranted);

    if (!allGranted) {
      _showPermissionDeniedDialog(context);
      print('Not all permissions are granted');
    }
    return allGranted;
  }

  Future<bool> _isBluetoothEnabled(BuildContext context) async {
    final isOn =
        await FlutterBluePlus.adapterState.first == BluetoothAdapterState.on;
    if (!isOn) {
      _showBluetoothDisabledDialog(context);
      print('Bluetooth is not enabled');
    }
    return isOn;
  }

  void _scanForDevices() async {
    isScanning = true;
    devices.clear();
    notifyListeners();

    // Set up scan results listener before starting the scan
    final scanResultsSubscription =
        FlutterBluePlus.scanResults.listen((results) {
      devices = results;
      notifyListeners();
    });

    try {
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));

      await Future.delayed(const Duration(seconds: 4));
      await FlutterBluePlus.stopScan();
    } catch (e) {
      print('An error occurred while scanning: $e');
    } finally {
      await scanResultsSubscription
          .cancel(); // Cancel the subscription to avoid memory leaks
      isScanning = false;
      notifyListeners();
    }
  }

  void handleDisconnection(BluetoothDevice device) {
    _attemptReconnect(device, 0, initialDelay);
  }

  void _attemptReconnect(BluetoothDevice device, int attempt, Duration delay) {
    if (attempt >= maxRetries) {
      print('Max retry limit reached. Stopping reconnection attempts.');
      return;
    }

    device.connectionState.listen((state) async {
      if (state == BluetoothConnectionState.disconnected) {
        print('${device.platformName} got disconnected');
        // Attempt to reconnect after a delay
        await Future.delayed(delay);
        try {
          await device.connect();
          print('Reconnected to ${device.platformName}');
          connectedDevice = device;
          notifyListeners();
        } catch (e) {
          print('Failed to reconnect: $e');
          // Increase the delay for the next attempt
          _attemptReconnect(device, attempt + 1, delay * 2);
        }
      }
    });
  }

  void _showPermissionDeniedDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Permissions Denied'),
              content: const Text(
                  'Please grant all the required permissions to use Bluetooth features.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ));
  }

  void _showBluetoothDisabledDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              backgroundColor: Colors.white,
              title: const Column(
                children: [
                  Icon(
                    Icons.bluetooth_disabled,
                    color: Colors.redAccent,
                    size: 40,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Bluetooth Disabled',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              content: const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Please enable Bluetooth and Location to scan for devices.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              actions: <Widget>[
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ));
  }
}
