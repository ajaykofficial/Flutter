import 'dart:async';

import 'package:eco_quest/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/blur-boy-playing_bg.jpg',
                  ),
                  fit: BoxFit.cover),
            ),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 400,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 10,
                            offset: Offset(0.0, 0.0),
                            color: Colors.black,
                          )
                        ]),
                    child: ClipOval(
                        child: Image.asset(
                      'assets/images/boy-playing_bg.jpg',
                      width: 200,
                      height: 200,
                    )),
                  ),
                  const Text(
                    'Bin Buddy',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        shadows: [
                          Shadow(
                            blurRadius: 5,
                            offset: Offset(3.0, 3.0),
                            color: Colors.black,
                          )
                        ],
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Norican-Regular'),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  LinearPercentIndicator(
                    animation: true,
                    animationDuration: 2500,
                    percent: 1.0,
                    progressColor: const Color.fromARGB(255, 52, 64, 234),
                    backgroundColor: const Color.fromARGB(255, 168, 111, 203),
                    lineHeight: 25,
                    barRadius: const Radius.circular(30),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
