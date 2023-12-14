// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nwss/await/loading.dart';
import 'package:nwss/constants/app_colors.dart';
import 'package:nwss/constants/const.dart';
import 'package:avatars/avatars.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      body: RefreshIndicator(
        backgroundColor: AppColor.primaryColorLight,
        color: AppColor.primaryColor,
        onRefresh: () async {
          (Duration(milliseconds: 1500));
        },
        child: StreamBuilder(
          stream: fbStore.collection('user').doc(email).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return LoadingScreen();
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset('assets/lottie/animation_loading.json',
                    width: 100, height: 100),
              );
            } else {
              return Container(
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: VStack(
                    [
                      Container(
                        padding: EdgeInsets.only(top: 50, bottom: 20, left: 20),
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
                              ], // Define your gradient colors here
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Avatar(
                                  elevation: 3,
                                  shape: AvatarShape.rectangle(
                                      60, 60, BorderRadius.circular(40)),
                                  name: email
                                      .toString()
                                      .toUpperCase(), // Uses name initials (up to two)
                                ),
                                Text(
                                  "   $email",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w100),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(right: 40, left: 40, bottom: 20),
                        child: Row(
                          children: [
                            Text(
                              "Account",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 40, left: 40),
                        child: Row(
                          children: [
                            Text("Account Info"),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 40, left: 40, top: 20),
                        child: Row(
                          children: [
                            Text("Change Password"),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                _showChangePassword(context);
                              },
                              child: Icon(Icons.arrow_forward_ios),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      Padding(
                        padding:
                            EdgeInsets.only(right: 40, left: 40, bottom: 20),
                        child: Row(
                          children: [
                            Text(
                              "About",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 40, left: 40),
                        child: Row(
                          children: [
                            Text("Terms and Conditions"),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                _showTermsAndConditions(context);
                              },
                              child: Icon(Icons.arrow_forward_ios),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 40, left: 40, top: 20),
                        child: Row(
                          children: [
                            Text("Guide"),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                _showGuide(context);
                              },
                              child: Icon(Icons.arrow_forward_ios),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 40, left: 40, top: 20),
                        child: Row(
                          children: [
                            Text('Log out'),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                _logOut(context);
                              },
                              child: Icon(
                                Icons.logout,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void _showChangePassword(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      'Change Password',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.cancel_outlined))
                  ],
                ),
                SizedBox(height: 20.0),
                Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: TextField(
                          keyboardType: TextInputType.visiblePassword,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 121, 121, 121),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelText: "New password",
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        child: TextField(
                          keyboardType: TextInputType.visiblePassword,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 121, 121, 121),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelText: "Confirm password",
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Spacer(),
                          SizedBox(
                            height: 35,
                            child: ElevatedButton(
                              onPressed: () async {},
                              style: ElevatedButton.styleFrom(
                                onPrimary: Colors.white,
                                primary: AppColor.primaryColor,
                                onSurface: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                "Save",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _showTermsAndConditions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      'Terms and Conditions',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.cancel_outlined))
                  ],
                ),
                SizedBox(height: 20.0),
                Container(
                  height: 400,
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
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _logOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Log Out'),
          content: Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                fbAuth.signOut();
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _showGuide(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      'Guide',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.cancel_outlined))
                  ],
                ),
                SizedBox(height: 20.0),
                Container(
                  height: 400,
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
                          initialUrl: '$usersGuide',
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
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
