import 'dart:async';
import 'package:binbuddy/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _logoAnimation;
  late Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _textAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    _animationController.forward();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.lightGreenAccent, // Updated background color
      body: Stack(children: [
        Image.asset(
          'assets/images/scbg.jpg',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo and App Name with animations
              ScaleTransition(
                scale: _logoAnimation,
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/bgs2.jpeg',
                      width: 180,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FadeTransition(
                opacity: _textAnimation,
                child: const Text(
                  'Bin Buddy',
                  style: TextStyle(
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 30.0,
                        offset: Offset(4.0, 4.0),
                      ),
                    ],
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Norican-Regular',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Progress Indicator
              LinearPercentIndicator(
                animation: true,
                animationDuration: 2500,
                percent: 1.0,
                progressColor: Colors.amberAccent, // Updated progress color
                backgroundColor: Colors.white,
                lineHeight: 20,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                barRadius: const Radius.circular(10),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
