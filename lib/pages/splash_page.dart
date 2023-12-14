import 'package:flutter/material.dart';
import 'dart:async'; // Import Dart's async library for Future.delayed

import 'auth/auth.wrapper.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Delay for 2 seconds and then navigate to AuthWrapper
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthWrapper()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              brightness == Brightness.light
                  ? Colors.blue.shade500
                  : Colors.blue.shade900,
              brightness == Brightness.light
                  ? Colors.green.shade300
                  : Colors.green.shade800,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/logo.png',
                width: 100,
                height: 100,
              ),
              const Text(
                "Welcome to NWSS",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
