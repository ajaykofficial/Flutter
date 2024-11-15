import 'package:binbuddy/pages/bluetooth_scanner.dart';
import 'package:binbuddy/pages/gaming_screen.dart';
import 'package:binbuddy/pages/home_screen.dart';
import 'package:binbuddy/pages/instruction_screen.dart';
import 'package:binbuddy/pages/level_screen.dart';
import 'package:binbuddy/pages/player_list.dart';
import 'package:binbuddy/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BluetoothDevicesModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        '/splashScreen': (context) => const SplashScreen(),
        'homeScreen': (context) => const HomeScreen(),
        'bluetoothDevices': (context) => const BluetoothDevices(),
        'playerList': (context) => const PlayerSelectionScreen(),
        'levelScreen': (context) => const LevelScreen(),
        'gameScreen': (context) => const GamingScreen(),
        'instructions': (context) => const InstructionsPage(),
        // 'resultScreen':(context) => ResultsScreen(),
      },
    );
  }
}
