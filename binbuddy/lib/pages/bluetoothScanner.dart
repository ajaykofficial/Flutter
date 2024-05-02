import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:binbuddy/pages/bluetoothManager.dart';

class BluetoothScanner extends StatefulWidget {
  final Function(BluetoothDevice) onDeviceSelected;

  const BluetoothScanner({super.key, required this.onDeviceSelected});

  @override
  _BluetoothScannerState createState() => _BluetoothScannerState();
}

class _BluetoothScannerState extends State<BluetoothScanner> {
  final bluetoothManager = BluetoothManager();
  BluetoothDevice? _connectedDevice; // State variable for connected device

  @override
  void initState() {
    super.initState();
    bluetoothManager.startScan();
  }

  @override
  void dispose() {
    bluetoothManager.stopScan(); // Stop scan to save battery
    super.dispose();
  }

  void connectToDevice(BluetoothDevice device) async {
    await bluetoothManager.connectToDevice(device);
    setState(() {
      _connectedDevice = device; // Set the connected device
    });
    widget.onDeviceSelected(device); // Pass the connected device back
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bluetooth Scanner",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: _connectedDevice != null
            ? Colors.green // Change color if connected
            : Colors.blueAccent, // Default color
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (_connectedDevice != null) // Show connected icon
            const Icon(
              Icons.bluetooth_connected,
              color: Colors.white,
            ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () => bluetoothManager.startScan(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 5,
              ),
              child: const Text(
                "Scan for Devices",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<ScanResult>>(
              stream: bluetoothManager.scanResults,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      "Error while scanning",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.redAccent,
                      ),
                    ),
                  );
                }

                final devices = snapshot.data ?? [];
                if (devices.isEmpty) {
                  return const Center(
                    child: Text(
                      "No devices found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: devices.length,
                  itemBuilder: (context, index) {
                    final device = devices[index].device;
                    return ListTile(
                      leading: const Icon(Icons.bluetooth),
                      title: Text(
                        device.platformName.isNotEmpty
                            ? device.platformName
                            : "Unknown Device",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        device.remoteId.toString(), // Device identifier
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      onTap: () => connectToDevice(device), // Connect on tap
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
