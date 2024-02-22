import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
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
              actions:  [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: GestureDetector(onTap: (){

                  },child: Icon(Icons.help)),
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
                child: Stack(
                  children: [
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            color: Colors.white,
                            width: double.infinity,
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          "Bills to pay: ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                        ),
                                        Image.asset(
                                          'assets/icons8-peso-100.png',
                                          scale: 4,
                                          color: Colors.blue,
                                        ),
                                        Text(
                                          bills!.toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 19),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                          Container(
                            color: Colors.white,
                            width: double.infinity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: ElevatedButton(
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
                                  "Pay",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
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
                          initialUrl: 'https://checkout.paymongo.com/cs_u6abKy2NDKE1dJLH51iaKgWW_client_F4U2DEB1Y4puj2VvpAf3THrN#cGtfdGVzdF8xRGZ0QlFiY3JzUFU4OVhOQTFvWDlYeHU=',
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
