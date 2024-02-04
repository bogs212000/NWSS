import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nwss/constants/const.dart';
import 'package:nwss/pages/auth/auth.wrapper.dart';


class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  bool isValidEmail = false;
  bool _isButtonDisabled = false;
  int _countdown = 60; // Initial countdown value in seconds
  late Timer _timer;
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
      } else {
        _timer.cancel(); // Stop the timer when countdown reaches 0
        setState(() {
          _isButtonDisabled = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
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
        title: Text(
          "Forgot Password",
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
        padding: EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Text('Please enter your email to receive the link for changing your password.')
                .animate()
                .fadeIn(curve: Curves.fastOutSlowIn)
                .move(delay: 100.ms, duration: 1000.ms),
            SizedBox(height: 20),
            Expanded(
              child: SizedBox(
                height: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // Align elements to the start (left) of the column
                  children: [
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: brightness == Brightness.light
                            ? Colors.white
                            : Colors.white.withOpacity(0.3),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'Email',
                        prefixIcon:
                            Icon(Icons.email_outlined, color: Colors.grey),
                      ),
                      onChanged: (text) {
                        setState(() {
                          isValidEmail = _isValidEmail(text);
                        });
                      },
                    ),
                    if (!isValidEmail && emailController.text.isNotEmpty)
                      const Padding(
                        padding: EdgeInsets.only(top: 4.0, left: 8.0),
                        // Adjust the padding as needed
                        child: Text(
                          'Invalid Email',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(curve: Curves.fastOutSlowIn)
                  .move(delay: 100.ms, duration: 1500.ms),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
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
                            _countdown = 60; // Reset countdown on button click
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
                  _isButtonDisabled ? "Resend $_countdown s" : "Send",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
    String emailRegex = r'^[a-z][\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
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
