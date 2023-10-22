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
      backgroundColor: AppColor.white,
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
              return Center(
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
              );
            } else {
              return Container(
                color: Colors.white,
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: VStack([
                    Container(
                      padding: EdgeInsets.only(top: 50, bottom: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.blue.shade500, Colors.green.shade300], // Define your gradient colors here
                          ),                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 20),
                              Text(
                                "Hello!",
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w100,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Container(
                              padding: EdgeInsets.all(15),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Bills to Pay",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.primaryColor),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/icons8-peso-100.png',
                                        scale: 4,
                                        color: AppColor.primaryColor,
                                      ),
                                      Text(
                                        "${snapshot.data['balance_to_pay']}",
                                        style: TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.black),
                                      ),

                                      Spacer(),
                                      SizedBox(
                                        height: 25,
                                        child: ElevatedButton(
                                          onPressed: () async {},
                                          style: ElevatedButton.styleFrom(
                                            onPrimary: Colors.white,
                                            primary: AppColor.primaryColor,
                                            onSurface: Colors.grey,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Pay",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10),
                                              ),
                                              SizedBox(width: 5),
                                              Image.asset(
                                                  "assets/gcash_icon.png")
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        Text(
                          "Menu",
                          style: GoogleFonts.nunitoSans(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Divider(),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 5, left: 20, bottom: 20),
                      child: Row(
                        children: [
                          GestureDetector(
                            child: Column(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: AppColor.primaryColorLight,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.asset(
                                      "assets/analytics_icon.png",
                                      scale: 2.5),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Analytics",
                                  style: TextStyle(
                                      color: AppColor.black, fontSize: 12),
                                ),
                              ],
                            ),
                            onTap: () async {
                              Navigator.of(context).push(_toAnalytics());
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
                                    color: AppColor.primaryColorLight,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.asset("assets/log_icon.png",
                                      scale: 3.5),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Transactions",
                                  style: TextStyle(
                                      color: AppColor.black, fontSize: 12),
                                )
                              ],
                            ),
                            onTap: () {
                              Navigator.of(context).push(_toTransaction());
                              ;
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
                                    color: AppColor.primaryColorLight,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.asset("assets/water_drop.png",
                                      scale: 3),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Price rate",
                                  style: TextStyle(
                                      color: AppColor.black, fontSize: 12),
                                )
                              ],
                            ),
                            onTap: () {
                              Navigator.of(context).push(_toPriceRate());
                            },
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        Text(
                          "News & Updates",
                          style: GoogleFonts.nunitoSans(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Divider(),
                    ),
                    SizedBox(
                      height: 500,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("NewsUpdate")
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Somthing went wrong!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 231, 25, 25),
                                  ),
                                )
                              ],
                            );
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              ],
                            );
                          }
                          if (snapshot.data?.size == 0) {
                            return Center(
                              child: Text('No Update yet!'),
                            );
                          }
                          Row(children: [
                            TextField(
                              decoration: InputDecoration(),
                            )
                          ]);
                          return ListView(
                            padding: EdgeInsets.only(top: 0),
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Card(
                                  shadowColor: Color.fromARGB(255, 34, 34, 34),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  color: AppColor.primaryColorLight,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Color(0xC2CADBFF),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              'assets/logo.png',
                                              scale: 10,
                                            ),
                                            Text(
                                              'Narra Water Supply System',
                                              maxLines: 1,
                                              softWrap: false,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Spacer(),
                                            Text(
                                              data['date'],
                                              maxLines: 1,
                                              softWrap: false,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w200),
                                            ),
                                          ],
                                        ),
                                        Divider(),
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                data['title'],
                                                maxLines: 1,
                                                softWrap: false,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                data['details'],
                                                maxLines: 3,
                                                softWrap: false,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w200),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
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

  Route _toAnalytics() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, anotherAnimation) => AnalyticsPage(),
      transitionDuration: Duration(milliseconds: 1000),
      reverseTransitionDuration: Duration(milliseconds: 200),
      transitionsBuilder: (context, animation, anotherAnimation, child) {
        animation = CurvedAnimation(
            parent: animation,
            reverseCurve: Curves.fastOutSlowIn,
            curve: Curves.fastLinearToSlowEaseIn);

        return SlideTransition(
            position: Tween(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
                .animate(animation),
            textDirection: TextDirection.rtl,
            child: AnalyticsPage());
      },
    );
  }

  Route _toTransaction() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, anotherAnimation) => LogPage(),
      transitionDuration: Duration(milliseconds: 1000),
      reverseTransitionDuration: Duration(milliseconds: 200),
      transitionsBuilder: (context, animation, anotherAnimation, child) {
        animation = CurvedAnimation(
            parent: animation,
            reverseCurve: Curves.fastOutSlowIn,
            curve: Curves.fastLinearToSlowEaseIn);

        return SlideTransition(
            position: Tween(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
                .animate(animation),
            textDirection: TextDirection.rtl,
            child: LogPage());
      },
    );
  }

  Route _toPriceRate() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, anotherAnimation) => PriceRate(),
      transitionDuration: Duration(milliseconds: 1000),
      reverseTransitionDuration: Duration(milliseconds: 200),
      transitionsBuilder: (context, animation, anotherAnimation, child) {
        animation = CurvedAnimation(
            parent: animation,
            reverseCurve: Curves.fastOutSlowIn,
            curve: Curves.fastLinearToSlowEaseIn);

        return SlideTransition(
            position: Tween(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
                .animate(animation),
            textDirection: TextDirection.rtl,
            child: PriceRate());
      },
    );
  }
}
