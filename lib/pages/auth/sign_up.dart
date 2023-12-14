// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nwss/constants/const.dart';
import 'login.dart';

final TextEditingController addressController = TextEditingController();
final TextEditingController fnameController = TextEditingController();
final TextEditingController mnameController = TextEditingController();
final TextEditingController lnameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController cpasswordController = TextEditingController();
String role = 'client';
String? verified = "Yes";
String dropdownvalue = '';
String dropdownvalue2 = 'ID1';
String dropdownvalue1 = 'ID1';

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
          "Sign up",
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
                      controller: fnameController,
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
                      controller: mnameController,
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
                      controller: lnameController,
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
  var item;
  var brgy = [
    '',
    'Antipuluan',
    'Aramaywan',
    'Bagong Sikat',
    'Batang-batang',
    'Bato-bato',
    'Burirao',
    'Caguisan',
    'Calategas',
    'Dumanguena',
    'El Vita',
    'Ipilan',
    'Malatgao',
    'Malinao',
    'Panacan',
    'Panacan 2',
    'Poblacion',
    'Princess Urduja',
    'Sandoval',
    'Tacras',
    'Teresa',
    'Tinagong Dagat',
  ];

  @override
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
          "Sign up",
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
                    Row(
                      children: [
                        Text("Select your Baranggay: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 121, 121, 121))),

                        //Address
                        DropdownButton(
                          focusColor: Colors.redAccent,
                          hint: Text("Address"),
                          // Initial Value
                          value: dropdownvalue,
                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),
                          // Array list of items
                          items: brgy.map((String brgy) {
                            return DropdownMenuItem(
                              value: brgy,
                              child: Text(brgy),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                            addressController.text = dropdownvalue;
                          },
                        ),
                      ],
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
                        labelText: 'More address info',
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
                  Navigator.of(context).push(_toSignupPage2());
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

  Route _toSignupPage2() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, anotherAnimation) => SignUpPage2(),
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
            child: SignUpPage2());
      },
    );
  }
}

//email/pass

class SignUpPage2 extends StatefulWidget {
  const SignUpPage2({super.key});

  @override
  State<SignUpPage2> createState() => _SignUpPage2State();
}

class _SignUpPage2State extends State<SignUpPage2> {
  @override
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
          "Sign up",
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
                        labelText: 'Input email',
                      ),
                      onChanged: (text) {},
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
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
                        labelText: 'Create password',
                      ),
                      onChanged: (text) {},
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: cpasswordController,
                      keyboardType: TextInputType.visiblePassword,
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
                        labelText: 'Confirm password',
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
                onPressed: () async {
                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty ||
                      cpasswordController.text.isEmpty) {
                    showAlertDialogError(context);
                  } else if (passwordController.text !=
                      cpasswordController.text) {
                    showAlertDialogError(context);
                  } else {
                    try {
                      await fbAuth.createUserWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim());
                      await fbStore
                          .collection("Users")
                          .doc(emailController.text)
                          .set(
                        {
                          "role": role,
                          "first": fnameController.text,
                          "middle": mnameController.text,
                          "last": lnameController.text,
                          "email": emailController.text.trim(),
                          "verified?": verified,
                          "address": addressController
                        },
                      );
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Color.fromARGB(255, 0, 179, 92),
                        content: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Thank you!',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        duration: Duration(seconds: 5),
                      ));
                    } on FirebaseAuthException catch (e) {
                      print(e);
                      if (e.code == "invalid-email") {
                        msg = "Invalid email.";
                      } else if (e.code == "email-already-in-use") {
                        msg = "email already in use";
                      } else if (e.code == "network-request-failed") {
                        msg = "No internet connection.";
                      } else if (e.code == "weak-password") {
                        msg = "Your password is weak";
                      } else {
                        msg = "Something went wrong!";
                      }
                      setState(() {});
                    }
                    setState(() {});
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
                  "Create",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  showAlertDialogError(BuildContext context) {
    Widget continueButton = TextButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Thank you"),
      content: Text(
          "Please verify your email first and wait for your account to be fully verified by the agencies."),
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
