// ignore_for_file: prefer_const_constructors, unnecessary_const

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:nwss/constants/app_colors.dart';

import 'fetch_chart_data.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  late List<ChartBarDataItem> customChartData = [
    ChartBarDataItem(color: const Color(0xFF8043F9), value: jan, x: 1.0),
    ChartBarDataItem(color: const Color(0xFF8043F9), value: feb, x: 2.0),
    ChartBarDataItem(color: const Color(0xFF8043F9), value: mar, x: 3.0),
    ChartBarDataItem(color: const Color(0xFF8043F9), value: apr, x: 4.0),
    ChartBarDataItem(color: const Color(0xFF8043F9), value: ma, x: 5.0),
    ChartBarDataItem(color: const Color(0xFF8043F9), value: jun, x: 6.0),
    ChartBarDataItem(color: const Color(0xFF8043F9), value: jul, x: 7.0),
    ChartBarDataItem(color: const Color(0xFF8043F9), value: aug, x: 8.0),
    ChartBarDataItem(color: const Color(0xFF8043F9), value: sep, x: 9.0),
    ChartBarDataItem(color: const Color(0xFF8043F9), value: oct, x: 10.0),
    ChartBarDataItem(color: const Color(0xFF8043F9), value: nov, x: 11.0),
    ChartBarDataItem(color: const Color(0xFF8043F9), value: dec, x: 12.0),
  ];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/lottie/loading.json', height: 50),
                  SizedBox(width: 5),
                  const Text(
                    "Loading please wait...",
                    style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.blueGrey,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          : Container(
              height: double.infinity,
              width: double.infinity,
              color: AppColor.white,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15, bottom: 15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.blue.shade500,
                          Colors.green.shade300
                        ], // Define your gradient colors here
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 40),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                size: 30,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.asset("assets/analytics_icon.png",
                                  scale: 3),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Analytics",
                              style: GoogleFonts.nunitoSans(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xFF8043F9),
                          radius: 5,
                        ),
                        const SizedBox(width: 5),
                        Text("Water Usage every Month"),
                        Spacer(),
                        Text("Year 2023"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.all(5),
                    height: 200,
                    child: Chart(
                      layers: [
                        ChartAxisLayer(
                          settings: const ChartAxisSettings(
                            x: ChartAxisSettingsAxis(
                              frequency: 1.0,
                              max: 12.0,
                              min: 1.0,
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 10.0,
                              ),
                            ),
                            y: ChartAxisSettingsAxis(
                              frequency: 100.0,
                              max: 500.0,
                              min: 0.0,
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 10.0,
                              ),
                            ),
                          ),
                          labelX: (value) => value.toInt().toString(),
                          labelY: (value) => value.toInt().toString(),
                        ),
                        ChartBarLayer(
                          items: customChartData,
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
