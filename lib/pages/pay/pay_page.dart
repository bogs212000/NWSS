// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nwss/await/fetch.dart';
import 'package:nwss/await/loading.dart';
import 'package:nwss/constants/const.dart';
import 'package:screenshot/screenshot.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;
import 'package:url_launcher/url_launcher.dart';
import '../../constants/app_colors.dart';
import 'Paymongo.dart'; // Import the 'ui' library for Image

class PayPage extends StatefulWidget {
  const PayPage({super.key});

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  final GlobalKey _containerKey = GlobalKey();
  bool isValidEmail = false;
  bool _isButtonDisabled = true;
  final TextEditingController amount = TextEditingController();
  final ref = FirebaseStorage.instance.ref().child('PaymentReceipt/$email');
  ScreenshotController screenshotController = ScreenshotController();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    amount.addListener(_validateAmount);
  }

  void _validateAmount() {
    setState(() {
      _isButtonDisabled =
          amount.text.isEmpty; // Disable the button if the amount is empty
    });
  }

  @override
  void dispose() {
    amount.removeListener(
        _validateAmount); // Remove the listener to prevent memory leaks
    super.dispose();
  }

  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return loading
        ? LoadingScreen()
        : Scaffold(
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
                  child: GestureDetector(onTap: () {
                    Navigator.pushNamed(context, '/support');
                  }, child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.support_agent),
                      Text('Support', style: TextStyle(fontSize: 10),)
                    ],
                  )),
                )
              ],
              title: Text(
                "Pay with Gcash",
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
              child: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 140),
                        child: Column(
                          children: [
                            SizedBox(height: 80),
                            //step1
                            Row(
                              children: [
                                Text(
                                  'Step 1:',
                                  style: TextStyle(fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                            SizedBox(height: 3),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    'Open the GCash app on your mobile device',
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 3),
                            Container(
                              color: Colors.white,
                              width: double.infinity,
                              height: 300,
                              child: Image.asset('assets/gcash/1.png'),
                            ),
                            SizedBox(height: 10),
                            //open gcash button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    String gcashUrl = 'https://www.gcash.com/';
                                    if (await canLaunch(gcashUrl)) {
                                      await launch(gcashUrl);
                                    } else {
                                      throw 'Could not launch $gcashUrl';
                                    }
                                    // try {
                                    //   final checkoutUrl = await createCheckoutSession();
                                    //   print('Checkout URL: $checkoutUrl');
                                    //   setState(() {
                                    //     checkoutURl = checkoutUrl as String?; // Assuming checkoutURl is a variable in your class
                                    //   });
                                    //   if (checkoutUrl != null) {
                                    //     Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //         builder: (context) => Paymongo(),
                                    //       ),
                                    //     );
                                    //   } else {
                                    //     // Handle the case where checkoutUrl is null
                                    //     print('Failed to retrieve checkout URL.');
                                    //   }
                                    // } catch (e) {
                                    //   // Handle any errors that occurred during the checkout process
                                    //   print('Error creating checkout session: $e');
                                    // }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    onPrimary: Colors.white,
                                    primary: Colors
                                        .blue, // Change this to your desired color
                                    onSurface: Colors.grey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: const Text(
                                    "Open Gcash App",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),

                            //step 2
                            Row(
                              children: [
                                Text(
                                  'Step 2:',
                                  style: TextStyle(fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                            SizedBox(height: 3),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    "If you're not already logged in, log in to your GCash account using your mobile number and PIN.",
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 3),
                            Container(
                              color: Colors.white,
                              width: double.infinity,
                              height: 300,
                              child: Image.asset('assets/gcash/2.png'),
                            ),
                            SizedBox(height: 10),
                            //step 3
                            Row(
                              children: [
                                Text(
                                  'Step 3:',
                                  style: TextStyle(fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                            SizedBox(height: 3),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    "On your GCash homepage, tap Send",
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 3),
                            Container(
                              color: Colors.white,
                              width: double.infinity,
                              height: 300,
                              child: Image.asset('assets/gcash/3.png'),
                            ),
                            SizedBox(height: 10),
                            //step4
                            Row(
                              children: [
                                Text(
                                  'Step 4:',
                                  style: TextStyle(fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                            SizedBox(height: 3),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    "Select Express Send",
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 3),
                            Container(
                              color: Colors.white,
                              width: double.infinity,
                              height: 300,
                              child: Image.asset('assets/gcash/4.png'),
                            ),
                            SizedBox(height: 10),
                            //step5
                            Row(
                              children: [
                                Text(
                                  'Step 5:',
                                  style: TextStyle(fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                            SizedBox(height: 3),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    "Enter the Gcash number of NWSS and the amount of bills to pay. Input the month you want to pay the bill. Tap Next.",
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 3),
                            Container(
                              color: Colors.white,
                              width: double.infinity,
                              height: 300,
                              child: Image.asset('assets/gcash/5.png'),
                            ),
                            SizedBox(height: 10),
                            //step6
                            Row(
                              children: [
                                Text(
                                  'Step 6:',
                                  style: TextStyle(fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                            SizedBox(height: 3),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    "Check the checkbox to confirm the details and tap Send.",
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 3),
                            Container(
                              color: Colors.white,
                              width: double.infinity,
                              height: 300,
                              child: Image.asset('assets/gcash/6.png'),
                            ),
                            SizedBox(height: 20),
                            //step7
                            Row(
                              children: [
                                Text(
                                  'Step 7:',
                                  style: TextStyle(fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                            SizedBox(height: 3),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    "Download or take a clear photo of the receipt and go back to the app. Tap Next below to proceed with the process.",
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ],
                            ),


                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          color: Colors.orangeAccent,
                          width: double.infinity,
                          child: Row(
                            children: [
                              Icon(Icons.warning_amber_rounded, color: Colors.red,),
                              SizedBox(width: 5),
                              Text('Please follow the instructions carefully.')
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.all(20),
                          width: double.infinity,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 45,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    Navigator.pushNamed(context, '/upload_receipt');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    onPrimary: Colors.white,
                                    primary: Colors
                                        .blue, // Change this to your desired color
                                    onSurface: Colors.grey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: const Text(
                                    "Next",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  void _showPay(BuildContext context) {
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
                        return Center();
                      } else {
                        return WebView(
                          initialUrl:
                              'https://checkout.paymongo.com/cs_u6abKy2NDKE1dJLH51iaKgWW_client_F4U2DEB1Y4puj2VvpAf3THrN#cGtfdGVzdF8xRGZ0QlFiY3JzUFU4OVhOQTFvWDlYeHU=',
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

  void _showPaymentSuccess() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Successful'),
          content: Text('Your payment was successful.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showPaymentError() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Failed'),
          content: Text('There was an error processing your payment.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
