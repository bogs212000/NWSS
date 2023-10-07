// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nwss/constants/app_colors.dart';

class LogPage extends StatefulWidget {
  const LogPage({super.key});

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.primaryColor,
        foregroundColor: AppColor.white,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColor.white,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15, bottom: 15),
              color: AppColor.primaryColor,
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset("assets/log_icon.png", scale: 3),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Transaction",
                    style: GoogleFonts.nunitoSans(
                        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
