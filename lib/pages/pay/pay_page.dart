import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nwss/constants/const.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayPage extends StatefulWidget {
  const PayPage({super.key});

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  bool isValidEmail = false;
  bool _isButtonDisabled = false;
  int _countdown = 60; // Initial countdown value in seconds
  late Timer _timer;
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.help),
          )
        ],
        title: Text(
          "Pay",
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
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                height: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // Align elements to the start (left) of the column
                  children: [
                    Container(
                      width: double.infinity,
                      height: 400,
                      child: WebView(
                        initialUrl:
                            'https://m.gcash.com/gcash-login-web/index.html#/',
                        // Set the URL you want to display
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebResourceError:
                            (WebResourceError webResourceError) {
                          // Handle the error here, e.g., display an error message.
                          print('Web Error: ${webResourceError.description}');
                        }, // Enable JavaScript
                      ),
                    ),
                    Expanded(child: Container(color: Colors.white))
                  ],
                ),
              )
                  .animate()
                  .fadeIn(curve: Curves.fastOutSlowIn)
                  .move(delay: 100.ms, duration: 1500.ms),
            ),

            Container(
              color: Colors.white,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: ElevatedButton(
                  onPressed: _isButtonDisabled
                      ? null
                      : () async {
                          try {
                            await fbAuth.sendPasswordResetEmail(
                                email: emailController.text.trim());
                            _showSuccessDialog();
                            emailController.clear();

                            setState(() {
                              _isButtonDisabled = true;
                              _countdown =
                                  60; // Reset countdown on button click
                            });
                          } on FirebaseAuthException catch (e) {
                            print(e.code);
                            print(e.message);
                            // Show the snackbar here
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: Colors.blue, // Change this to your desired color
                    onSurface: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "Submit paymets",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool _isValidEmail(String email) {
    // Regular expression for a simple email validation
    String emailRegex = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regex = RegExp(emailRegex);
    return regex.hasMatch(email);
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Lottie.asset('assets/lottie/checkEmail.json'),
          content: Text(
              'An email containing a link to reset your password has been sent to your email address.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
