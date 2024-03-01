// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nwss/await/loading.dart';
import 'package:nwss/constants/const.dart';
import 'package:uuid/uuid.dart';

class UploadReceipt extends StatefulWidget {
  const UploadReceipt({super.key});

  @override
  State<UploadReceipt> createState() => _UploadReceiptState();
}

class _UploadReceiptState extends State<UploadReceipt> {
  bool loading = false;
  final TextEditingController refNoController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/support');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.support_agent),
                        Text(
                          'Support',
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                )
              ],
              title: Text(
                "Upload receipt",
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
            body: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 100, left: 20, right: 20, bottom: 30),
                      child: Column(
                        children: [
                          Text(
                              'Hi Mr./Mrs. ${fullname!}, Please make sure you paid the exact amount of ₱${bills!.toString()} for the month of ${month!}'),
                          SizedBox(height: 20),
                          Container(),
                          SizedBox(height: 20),
                          SizedBox(
                            height: 60,
                            child: TextField(
                              controller: refNoController,
                              keyboardType: TextInputType.number,
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
                                hintText: 'Ref no.',
                                prefixIcon: Icon(
                                  Icons.numbers,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                              'Verifying your payment will take 10 to 15 minutes. If something went wrong, please message the support team.'),
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
                            Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.red,
                            ),
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
                                  String paymentId = Uuid().v4();
                                  try {
                                    await FirebaseFirestore.instance.collection('clientsPayment').doc('paymentId').set({
                                     'paymentId': paymentId,
                                     'createdAt': DateTime.now(),
                                      'accountId': account_ID,
                                      'name': fullname!,
                                      'amount': bills!,
                                      'month': month,
                                      'confirmed?': false,
                                     'gcashRefNo': refNoController.text,
                                    });
                                  } catch (e) {
                                    return print(e);
                                  }
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
                                  "Submit",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
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
          );
  }
}
