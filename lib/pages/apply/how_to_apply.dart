import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nwss/constants/const.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HowToApply extends StatefulWidget {
  const HowToApply({super.key});

  @override
  State<HowToApply> createState() => _HowToApplyState();
}

class _HowToApplyState extends State<HowToApply> {
  bool walkin = false;
  bool online = false;

  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 30,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Info",
          style: GoogleFonts.nunitoSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
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
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text('How to apply Online?'),
                  !online
                      ? GestureDetector(onTap: (){setState(() {
                        online = true;
                      });}, child: Icon(Icons.keyboard_arrow_up))
                      : GestureDetector(onTap: (){setState(() {
                    online = false;
                  });}, child: Icon(Icons.keyboard_arrow_down))
                ],
              ),
              !online ? SizedBox(): Container(height: 50, width: double.infinity, color: Colors.blue),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('How to apply? (Walk-in)'),
                  !walkin
                      ? GestureDetector(onTap: (){setState(() {
                    walkin = true;
                  });}, child: Icon(Icons.keyboard_arrow_up))
                      : GestureDetector(onTap: (){setState(() {
                    walkin = false;
                  });}, child: Icon(Icons.keyboard_arrow_down))
                ],
              ),
              !walkin ? SizedBox(): Container(height: 50, width: double.infinity, color: Colors.blue)
            ],
          ),
        ),
      ),
    );
  }
}
