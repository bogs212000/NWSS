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
  List<ChartBarDataItem> customChartData = [
    ChartBarDataItem(color: const Color(0xFF8043F9), value: 100, x: 1.0),
    ChartBarDataItem(color: const Color(0xFF8043F9), value: 80, x: 2.0),
    ChartBarDataItem(color: const Color(0xFF8043F9), value: 120, x: 3.0),
    ChartBarDataItem(color: const Color(0xFF8043F9), value: 70, x: 4.0),
    ChartBarDataItem(color: const Color(0xFF8043F9), value: 90, x: 5.0),
    ChartBarDataItem(color: const Color(0xFF8043F9), value: 60, x: 6.0),
    ChartBarDataItem(color: const Color(0xFF8043F9), value: 110, x: 7.0),
    ChartBarDataItem(color: const Color(0xFF8043F9), value: 40, x: 8.0),
    ChartBarDataItem(color: const Color(0xFF8043F9), value: 40, x: 9.0),
    ChartBarDataItem(color: const Color(0xFF8043F9), value: 220, x: 10.0),
    ChartBarDataItem(color: const Color(0xFF8043F9), value: 74, x: 11.0),
    ChartBarDataItem(color: const Color(0xFF8043F9), value: 90, x: 12.0),
  ];

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
            SizedBox(height: 0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xFF8043F9),
                    radius: 5,
                  ),
                  SizedBox(width: 5),
                  Text("Water Usage every Month"),
                  Spacer(),
                  Text("Year 2023")
                ],
              ),
            ),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.all(5),
              height: 200,
              child: Chart(
                layers: [
                  ChartAxisLayer(
                    settings: ChartAxisSettings(
                      x: ChartAxisSettingsAxis(
                        frequency: 1.0,
                        max: 12.0,
                        min: 1.0,
                        textStyle: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 10.0,
                        ),
                      ),
                      y: ChartAxisSettingsAxis(
                        frequency: 100.0,
                        max: 300.0,
                        min: 0.0,
                        textStyle: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                    labelX: (value) => value.toInt().toString(),
                    labelY: (value) => value.toInt().toString(),
                  ),
                  ChartBarLayer(
                    items: customChartData,
                    // List.generate(
                    //   12,
                    //   (index) => ChartBarDataItem(
                    //     color: const Color(0xFF8043F9),
                    //     value: Random().nextInt(280) + 20,
                    //     x: index.toDouble() + 7,
                    //   ),
                    // ),
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
