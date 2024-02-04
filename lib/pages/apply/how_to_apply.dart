import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nwss/constants/const.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../constants/app_colors.dart';

class HowToApply extends StatefulWidget {
  const HowToApply({super.key});

  @override
  State<HowToApply> createState() => _HowToApplyState();
}

class _HowToApplyState extends State<HowToApply> {
  bool walkin = false;
  bool online = false;

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
          "Info",
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
        padding: EdgeInsets.all(10),
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text('How to apply Online?'),
                  !online
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              online = true;
                            });
                          },
                          child: Icon(Icons.keyboard_arrow_up))
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              online = false;
                            });
                          },
                          child: Icon(Icons.keyboard_arrow_down))
                ],
              ),
              !online
                  ? SizedBox()
                  : Container(
                      height: 50, width: double.infinity, color: Colors.blue),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('How to apply? (Walk-in)'),
                  !walkin
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              walkin = true;
                            });
                          },
                          child: Icon(Icons.keyboard_arrow_up))
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              walkin = false;
                            });
                          },
                          child: Icon(Icons.keyboard_arrow_down))
                ],
              ),
              !walkin
                  ? SizedBox()
                  : Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Text(
                              "To apply, please fill out the form below and generate the PDF file. Before printing, ensure you have read the document thoroughly. Once printed, bring the document and all required materials to the Narra Water Supply Office. Thank you for using this app."),
                          SizedBox(height: 20),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            style: const TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              focusColor: Colors.blue[200],
                              hintText: "First name",
                              filled: true,
                              fillColor: Colors.blue[50],
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              labelStyle: const TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20.0)),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            style: const TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              focusColor: Colors.blue[200],
                              hintText: "Middle name",
                              filled: true,
                              fillColor: Colors.blue[50],
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              labelStyle: const TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20.0)),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            style: const TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              focusColor: Colors.blue[200],
                              hintText: "Last name",
                              filled: true,
                              fillColor: Colors.blue[50],
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              labelStyle: const TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20.0)),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            style: const TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              focusColor: Colors.blue[200],
                              hintText: "Address",
                              filled: true,
                              fillColor: Colors.blue[50],
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              labelStyle: const TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20.0)),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("+63"),
                              SizedBox(width: 5),
                              SizedBox(
                                width: 200,
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(fontSize: 15),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    focusColor: Colors.blue[200],
                                    hintText: "Contact Number",
                                    filled: true,
                                    fillColor: Colors.blue[50],
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: Colors.white)),
                                    labelStyle:
                                        const TextStyle(color: Colors.white),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            height: 30,
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
                              child: const Text(
                                "Generate my PDF",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
