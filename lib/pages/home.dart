// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nwss/constants/app_colors.dart';
import 'package:nwss/pages/analytics/alalytics.dart';
import 'package:nwss/pages/log/log.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        backgroundColor: AppColor.primaryColorLight,
        color: AppColor.primaryColor,
        onRefresh: () async {
          (Duration(milliseconds: 1500));
        },
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          color: AppColor.primaryColor,
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.all(10),
                  height: 150,
                  decoration: BoxDecoration(
                    color: AppColor.primaryColorLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 20),
                        height: 150,
                        width: 140,
                        child: PieChart(
                          PieChartData(
                            centerSpaceColor: AppColor.primaryColorLight,
                            startDegreeOffset: 0,
                            sectionsSpace: 0,
                            borderData: FlBorderData(
                              show: true, // Show or hide the border
                              border: const Border(
                                top: BorderSide(
                                  color: Colors.black,
                                  width: 2, // Border width
                                ),
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 2, // Border width
                                ),
                                left: BorderSide(
                                  color: Colors.black,
                                  width: 1, // Border width
                                ),
                                right: BorderSide(
                                  color: Colors.black,
                                  width: 2, // Border width
                                ),
                              ),
                            ),
                            sections: [
                              PieChartSectionData(
                                badgeWidget:
                                    Icon(Icons.water, color: Colors.blue),
                                radius: 24,
                                value: 10,
                                color: AppColor.white,
                                title: '...',
                                showTitle: true,
                              ),
                              PieChartSectionData(
                                titleStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                value: 21,
                                radius: 25,
                                color: Colors.green[300],
                                title: 'PHP 110.00',
                                showTitle: true,
                              ),
                              // Add more sections as needed
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                "Water Bill this Month:",
                                style: GoogleFonts.ptSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.primaryColor),
                              ),
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Lottie.asset("assets/green_dots.json", height: 30, width: 30),

                                  Text(
                                    "110.00",
                                    style: GoogleFonts.sourceCodePro(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                //more
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "More",
                      style: GoogleFonts.nunitoSans(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    GestureDetector(
                      child: Column(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Image.asset("assets/analytics_icon.png",
                                scale: 2),
                          ),
                          Text(
                            "Analytics",
                            style:
                                TextStyle(color: AppColor.white, fontSize: 12),
                          ),
                        ],
                      ),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AnalyticsPage(), // Replace with the appropriate widget for your new screen
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      child: Column(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Image.asset("assets/log_icon.png", scale: 3),
                          ),
                          Text(
                            "Transactions",
                            style:
                                TextStyle(color: AppColor.white, fontSize: 12),
                          )
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                LogPage(), // Replace with the appropriate widget for your new screen
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      child: Column(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Image.asset("assets/water_drop.png",
                                scale: 2.5),
                          ),
                          Text(
                            "Price rate",
                            style:
                                TextStyle(color: AppColor.white, fontSize: 12),
                          )
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                LogPage(), // Replace with the appropriate widget for your new screen
                          ),
                        );
                      },
                    ),
                  ],
                ),
                //pay
                SizedBox(height: 15),
                Row(
                  children: [
                    Text(
                      "Pay",
                      style: GoogleFonts.nunitoSans(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Divider(),
                SizedBox(height: 5),
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image.asset("assets/gcash_icon.png", scale: 2),
                        ),
                        Text(
                          "Gcash",
                          style: TextStyle(color: AppColor.white, fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                  ],
                ),
                //news and updates
                SizedBox(height: 15),
                Row(
                  children: [
                    Text(
                      "News & Updates",
                      style: GoogleFonts.nunitoSans(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Divider(),
                SizedBox(height: 5),
                Column(
                  children: [
                    Container(
                        padding: EdgeInsets.all(10),
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColor.primaryColorLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [],
                        )),
                    SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
