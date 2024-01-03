import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nwss/constants/const.dart';
import 'package:webview_flutter/webview_flutter.dart';


class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {

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
          "Terms and conditions",
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
        height: double.infinity,
        width: double.infinity,
        child: FutureBuilder(
          future: Future.delayed(Duration(seconds: 2), () {}),
          // Simulate a delay
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While fetching the web page, display a loading screen
              return Center(
                child: Lottie.asset('assets/lottie/loading.json',
                    height: 100),
              );
            } else {
              return WebView(
                initialUrl: '$termsConditions',
                // Set the URL you want to display
                javascriptMode: JavascriptMode.unrestricted,
                onWebResourceError:
                    (WebResourceError webResourceError) {
                  // Handle the error here, e.g., display an error message.
                  print('Web Error: ${webResourceError.description}');
                }, // Enable JavaScript
              );
            }
          },
        ),
      ),
    );
  }
}
