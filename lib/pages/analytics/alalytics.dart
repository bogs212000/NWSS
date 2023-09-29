import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:nwss/constants/app_colors.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
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
                    child: Image.asset("assets/analytics_icon.png", scale: 3),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Analytics",
                    style: GoogleFonts.nunitoSans(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 200,
              child: Chart(
                layers: [
                  ChartAxisLayer(
                    settings: ChartAxisSettings(
                      x: ChartAxisSettingsAxis(
                        frequency: 1.0,
                        max: 13.0,
                        min: 7.0,
                        textStyle: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 10.0,
                        ),
                      ),
                      y: ChartAxisSettingsAxis(
                        frequency: 100.0,
                        max: 300.0,
                        min: 0.0,
                        textStyle: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                    labelX: (value) => value.toInt().toString(),
                    labelY: (value) => value.toInt().toString(),
                  ),
                  ChartBarLayer(
                    items: List.generate(
                      13 - 7 + 1,
                      (index) => ChartBarDataItem(
                        color: const Color(0xFF8043F9),
                        value: Random().nextInt(280) + 20,
                        x: index.toDouble() + 7,
                      ),
                    ),
                    settings: const ChartBarSettings(
                      thickness: 8.0,
                      radius: BorderRadius.all(
                        Radius.circular(4.0),
                      ),
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
}
