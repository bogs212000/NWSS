// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nwss/await/loading.dart';
import 'package:nwss/constants/app_colors.dart';
import 'package:nwss/constants/const.dart';
import 'package:nwss/pages/analytics/alalytics.dart';
import 'package:nwss/pages/log/log.dart';
import 'package:nwss/pages/price_rate/price_rate.dart';
import 'package:velocity_x/velocity_x.dart';

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
        child: StreamBuilder(
          stream: fbStore.collection('user').doc(email).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return LoadingScreen();
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingScreen();
            } else {
              return Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                color: AppColor.primaryColor,
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: VStack([
                    SizedBox(height: 5),
                    Row(
                      children: [
                        // Container(
                        //   padding: EdgeInsets.only(right: 20),
                        //   height: 150,
                        //   width: 140,
                        //   child:
                        //   PieChart(
                        //     PieChartData(
                        //       centerSpaceColor: AppColor.primaryColorLight,
                        //       startDegreeOffset: 0,
                        //       sectionsSpace: 0,
                        //       borderData: FlBorderData(
                        //         show: true, // Show or hide the border
                        //         border: const Border(
                        //           top: BorderSide(
                        //             color: Colors.black,
                        //             width: 2, // Border width
                        //           ),
                        //           bottom: BorderSide(
                        //             color: Colors.black,
                        //             width: 2, // Border width
                        //           ),
                        //           left: BorderSide(
                        //             color: Colors.black,
                        //             width: 1, // Border width
                        //           ),
                        //           right: BorderSide(
                        //             color: Colors.black,
                        //             width: 2, // Border width
                        //           ),
                        //         ),
                        //       ),
                        //       sections: [
                        //         PieChartSectionData(
                        //           badgeWidget:
                        //               Icon(Icons.water, color: Colors.blue),
                        //           radius: 24,
                        //           value: 10,
                        //           color: AppColor.white,
                        //           title: '...',
                        //           showTitle: true,
                        //         ),
                        //         PieChartSectionData(
                        //           titleStyle: TextStyle(
                        //               fontWeight: FontWeight.bold,
                        //               color: Colors.white),
                        //           value: 21,
                        //           radius: 25,
                        //           color: Colors.green[300],
                        //           title: 'PHP ${snapshot.data['balance_to_pay']}',
                        //           showTitle: true,
                        //         ),
                        //         // Add more sections as needed
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "${snapshot.data['balance_to_pay']}",
                                              style: GoogleFonts.aBeeZee(
                                                fontSize: 40,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "PHP",
                                              style: GoogleFonts.sourceCodePro(
                                                fontSize: 15,
                                                color: AppColor.primaryColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Current Bill to Pay",
                                      style: GoogleFonts.sourceCodePro(
                                        fontSize: 12,
                                        color: AppColor.primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    Image.asset(
                                        "assets/icons8-card-payment-100.png",
                                        scale: 2),
                                    SizedBox(
                                      height: 25,
                                      child: ElevatedButton(
                                        onPressed: () async {},
                                        child: Text(
                                          "Pay",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          onPrimary: Colors.white,
                                          primary: AppColor.primaryColor,
                                          onSurface: Colors.grey,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
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

                    Row(
                      children: [
                        GestureDetector(
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset("assets/analytics_icon.png",
                                    scale: 2.5),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Analytics",
                                style: TextStyle(
                                    color: AppColor.white, fontSize: 12),
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
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset("assets/log_icon.png",
                                    scale: 3.5),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Transactions",
                                style: TextStyle(
                                    color: AppColor.white, fontSize: 12),
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
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset("assets/water_drop.png",
                                    scale: 3),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Price rate",
                                style: TextStyle(
                                    color: AppColor.white, fontSize: 12),
                              )
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PriceRate(), // Replace with the appropriate widget for your new screen
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

                    SizedBox(height: 5),
                    Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.asset("assets/gcash_icon.png",
                                  scale: 3),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Gcash",
                              style: TextStyle(
                                  color: AppColor.white, fontSize: 12),
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
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ]),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
