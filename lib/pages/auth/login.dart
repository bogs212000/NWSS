// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nwss/await/fetch.dart';
import 'package:nwss/await/loading.dart';
import 'package:nwss/constants/app_colors.dart';
import 'package:nwss/pages/auth/sign_up.dart';
import 'package:nwss/pages/terms.conditions/terms_and_conditions.dart';

import '../../constants/const.dart';
import '../apply/how_to_apply.dart';
import 'forgot_pass.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;

  bool _isPasswordVisible = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void initState() {
    super.initState();
    fetchTermsConditions(setState);
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return isLoading
        ? LoadingScreen()
        : Scaffold(
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
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Log in",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text("Welcome back to NWSS app.",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w300, color: Colors.white)),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 60,
                              child: TextField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
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
                                  hintText: 'Email',
                                  prefixIcon: Icon(
                                    Icons.email_outlined, color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              height: 60,
                              child: TextField(
                                controller: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: !_isPasswordVisible,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
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
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  hintText: 'Password',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible =
                                            !_isPasswordVisible;
                                      });
                                    },
                                  ),
                                  prefixIcon: Icon(Icons.lock, color: Colors.grey),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    Navigator.of(context).push(_toForgotPass());
                                  },
                                  child: Text(
                                    "Forgot password?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                Spacer(),
                                SizedBox(
                                  height: 35,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        isLoading = true;
                                      });

                                      try {
                                        await fbAuth.signInWithEmailAndPassword(
                                            email: emailController.text.trim(),
                                            password:
                                                passwordController.text.trim());
                                        setState(() {
                                          isLoading = false;
                                        });
                                      } catch (e) {
                                        setState(() => isLoading = false);

                                        if (e is FirebaseAuthException) {
                                          // Handle specific Firebase authentication errors
                                          if (e.code == 'user-not-found' ||
                                              e.code == 'wrong-password') {
                                            // Incorrect email or password
                                            _showErrorDialog(
                                                "Invalid email or password");
                                          } else if (e.code ==
                                              'network-request-failed') {
                                            // No internet connection
                                            _showErrorDialog(
                                                "No internet connection");
                                          } else {
                                            // Handle other Firebase authentication errors
                                            _showErrorDialog(
                                                "An error occurred: ${e.message}");
                                          }
                                        } else {
                                          // Handle other types of errors
                                          _showErrorDialog(
                                              "An unexpected error occurred");
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      onPrimary: Colors.white,
                                      primary: AppColor.primaryColor,
                                      onSurface: Colors.grey,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Text(
                                      "Log in",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(width: 20),
                          Text(
                            "Don't have an Account?",
                            style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300),
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.of(context).push(_toSignUp());
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(_toHowToApply());
                            },
                            child: Text(
                              "How do I apply?",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(_toTermsAndConditions());
                            },
                            child: Text(
                              "Terms and conditions",
                              style: TextStyle(
                                fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Route _toForgotPass() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, anotherAnimation) => ForgotPassPage(),
      transitionDuration: Duration(milliseconds: 1000),
      reverseTransitionDuration: Duration(milliseconds: 200),
      transitionsBuilder: (context, animation, anotherAnimation, child) {
        animation = CurvedAnimation(
            parent: animation,
            reverseCurve: Curves.fastOutSlowIn,
            curve: Curves.fastLinearToSlowEaseIn);

        return SlideTransition(
            position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                .animate(animation),
            child: ForgotPassPage());
      },
    );
  }
  Route _toTermsAndConditions() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, anotherAnimation) => TermsAndConditions(),
      transitionDuration: Duration(milliseconds: 1000),
      reverseTransitionDuration: Duration(milliseconds: 200),
      transitionsBuilder: (context, animation, anotherAnimation, child) {
        animation = CurvedAnimation(
            parent: animation,
            reverseCurve: Curves.fastOutSlowIn,
            curve: Curves.fastLinearToSlowEaseIn);

        return SlideTransition(
            position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                .animate(animation),
            child: TermsAndConditions());
      },
    );
  }

  Route _toHowToApply() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, anotherAnimation) => HowToApply(),
      transitionDuration: Duration(milliseconds: 1000),
      reverseTransitionDuration: Duration(milliseconds: 200),
      transitionsBuilder: (context, animation, anotherAnimation, child) {
        animation = CurvedAnimation(
            parent: animation,
            reverseCurve: Curves.fastOutSlowIn,
            curve: Curves.fastLinearToSlowEaseIn);

        return SlideTransition(
            position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                .animate(animation),
            child: HowToApply());
      },
    );
  }

  Route _toSignUp() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, anotherAnimation) => SignUpPage(),
      transitionDuration: Duration(milliseconds: 1000),
      reverseTransitionDuration: Duration(milliseconds: 200),
      transitionsBuilder: (context, animation, anotherAnimation, child) {
        animation = CurvedAnimation(
            parent: animation,
            reverseCurve: Curves.fastOutSlowIn,
            curve: Curves.fastLinearToSlowEaseIn);

        return SlideTransition(
            position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                .animate(animation),
            child: SignUpPage());
      },
    );
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
