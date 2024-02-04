import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nwss/await/loading.dart';
import 'package:nwss/constants/const.dart';
import 'package:screenshot/screenshot.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;
import '../../constants/app_colors.dart'; // Import the 'ui' library for Image

class Paymongo extends StatefulWidget {
  const Paymongo({super.key});

  @override
  State<Paymongo> createState() => _PaymongoState();
}

class _PaymongoState extends State<Paymongo> {
  final GlobalKey _containerKey = GlobalKey();
  late WebViewController _webViewController;
  bool loading = false;
  ScrollController _scrollController = ScrollController();
  final TextEditingController amount = TextEditingController();
  final ref = FirebaseStorage.instance.ref().child('PaymentReceipt/$email');
  ScreenshotController screenshotController = ScreenshotController();
  bool paymentReceived = false; // Track if payment is received

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // User has scrolled to the bottom, refresh the page
      _webViewController.reload();
    }
  }

  Future<void> _captureAndUploadScreenshot() async {
    setState(() {
      loading = true;
    });
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE, yyyy-MM-dd').format(now);
    String formattedTime = DateFormat('h:mm a').format(now);

    RenderRepaintBoundary boundary = _containerKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary;

    // Convert the render object to an image
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    // Create a temporary file to write the image data
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File tempFile = File('$tempPath/screenshot.png');
    await tempFile.writeAsBytes(pngBytes);

    // Upload the temporary file to Firebase Storage
    try {
      final ref = FirebaseStorage.instance.ref().child(
          'PaymentReceipt/${fullname}-${formattedDate}-${formattedTime}');
      await ref.putFile(tempFile);
      String downloadUrl = await ref.getDownloadURL();
      await fbStore
          .collection("user")
          .doc(email)
          .collection("history")
          .doc("$formattedDate-$formattedTime")
          .set({
        'createdAt': now,
        'date': "$formattedDate, $formattedTime",
        'account_id': account_ID,
        'name': fullname,
        'modeOfPayment': 'Online Payment',
        'amount': double.parse(amount.text),
        'ReceiptUrl': downloadUrl,
      });

      await fbStore
          .collection("transactions")
          .doc("$fullname-$formattedDate-$formattedTime")
          .set({
        'doc_id': "$fullname-$formattedDate-$formattedTime",
        'createdAt': now,
        'date': "$formattedDate, $formattedTime",
        'account_id': account_ID,
        'name': fullname,
        'modeOfPayment': 'Online Payment',
        'amount': double.parse(amount.text),
        'ReceiptUrl': downloadUrl,
        'confirmed?': false,
        'month': month,
      });

      await fbStore
          .collection("Accounts")
          .doc(account_ID)
          .collection("bills")
          .doc("2023")
          .collection("month")
          .doc("$month")
          .update({
        "bills": 0.0,
        "paid?": false,
      });
      print(downloadUrl);
      amount.clear();
      // Perform other actions like updating Firestore
      setState(() {
        loading = false;
      });
    } catch (e) {
      // Handle Firebase Storage errors
      print(e);
      setState(() {
        loading = false;
      });
    }
  }

  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return loading
        ? const LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: GestureDetector(onTap: () {}, child: Icon(Icons.help)),
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
            body: Column(
              children: [
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollNotification) {
                      if (scrollNotification is ScrollEndNotification &&
                          _scrollController.position.extentAfter == 0) {
                        _webViewController.reload();
                      }
                      return false;
                    },
                    child: Container(
                        key: _containerKey,
                        width: double.infinity,
                        height: 600,
                        child:WebView(
                          initialUrl: '$checkoutURl',
                          javascriptMode: JavascriptMode.unrestricted,
                          onWebViewCreated: (WebViewController webViewController) {
                            // Save the reference to the web view controller for later use
                            _webViewController = webViewController;
                          },
                          onPageFinished: (String url) {
                            setState(() {
                              checkoutURl = url;
                            });

                            // Add a click event listener to all buttons with the class 'ant-btn ant-btn-primary'
                            _webViewController.evaluateJavascript('''
      (function() {
       
        var buttons = document.querySelectorAll('.ant-btn.ant-btn-primary');
       
        buttons.forEach(function(button) {
          button.addEventListener('click', function() {
          
            window.flutter_inappwebview.callHandler('onButtonClick', button.textContent);
          });
        });
      })();
    ''');
                          },
                          onWebResourceError: (WebResourceError webResourceError) {
                            print('Web Error: ${webResourceError.description}');
                          },
                          // Add a JavaScript handler to receive messages from the WebView
                          javascriptChannels: {
                            JavascriptChannel(
                              name: 'flutter_inappwebview',
                              onMessageReceived: (JavascriptMessage message) {
                                // Handle messages from the WebView here
                                print('Message received from WebView: ${message.message}');
                                // Check if the button was clicked and perform an action
                                if (message.message == 'Ant Design Button Clicked') {
                                  // Do something when the button is clicked
                                  print('Ant Design Button Clicked');
                                }
                              },
                            ),
                          },
                        )


                    ),
                  ),
                ),
                if (paymentReceived !=
                    false) // Show the checkout URL if it's not null
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        _captureAndUploadScreenshot();
                      },
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.white,
                        primary:
                            Colors.blue, // Change this to your desired color
                        onSurface: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "Finish",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    // Text(
                    //   'Checkout URL: $checkoutURl',
                    //   style: TextStyle(
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                  ),
              ],
            ),
          );
  }
}
