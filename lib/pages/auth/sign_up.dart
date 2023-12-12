// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'login.dart';

final TextEditingController addressController = TextEditingController();
final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController cpasswordController = TextEditingController();

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            // ignore: unrelated_type_equality_checks
            brightness == ThemeMode.light ? Colors.blue : Colors.blue.shade800,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Text('Kindly provide your accurate identity details for our records. Your cooperation is appreciated.')
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
                        labelText: 'First name',
                      ),
                      onChanged: (text) {},
                    ),
                    SizedBox(height: 10),
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
                        labelText: 'Middle name',
                      ),
                      onChanged: (text) {},
                    ),
                    SizedBox(height: 10),
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
                        labelText: 'Last name',
                      ),
                      onChanged: (text) {},
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
                onPressed: () {
                  Navigator.of(context).push(_toSignupPage1());
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
                  "Next",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Route _toSignupPage1() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, anotherAnimation) => SignUpPage1(),
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
            child: SignUpPage1());
      },
    );
  }
}

//Adress
class SignUpPage1 extends StatefulWidget {
  const SignUpPage1({super.key});

  @override
  State<SignUpPage1> createState() => _SignUpPage1State();
}

class _SignUpPage1State extends State<SignUpPage1> {
  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            // ignore: unrelated_type_equality_checks
            brightness == ThemeMode.light ? Colors.blue : Colors.blue.shade800,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Text('Kindly provide your accurate identity details for our records. Your cooperation is appreciated.')
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
                        labelText: 'First name',
                      ),
                      onChanged: (text) {},
                    ),
                    SizedBox(height: 10),
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
                        labelText: 'Middle name',
                      ),
                      onChanged: (text) {},
                    ),
                    SizedBox(height: 10),
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
                        labelText: 'Last name',
                      ),
                      onChanged: (text) {},
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: Colors.blue, // Change this to your desired color
                  onSurface: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "Next",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Route _toLogin() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, anotherAnimation) => LoginPage(),
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
            child: LoginPage());
      },
    );
  }
}
