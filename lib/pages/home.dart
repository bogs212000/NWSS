// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nwss/await/fetch.dart';
import 'package:nwss/await/fetch_online_pay.dart';
import 'package:nwss/await/loading.dart';
import 'package:nwss/await/release.dart';
import 'package:nwss/constants/app_colors.dart';
import 'package:nwss/constants/const.dart';
import 'package:nwss/pages/analytics/alalytics.dart';
import 'package:nwss/pages/analytics/fetch_chart_data.dart';
import 'package:nwss/pages/log/log.dart';
import 'package:nwss/pages/pay/pay_page.dart';
import 'package:nwss/pages/price_rate/price_rate.dart';
import 'package:nwss/pages/support/support.page.dart';
import 'package:velocity_x/velocity_x.dart';

import 'bills/bills.dart';
import 'force_update.dart';

int newsUpdate = 400;
String greeting = "";

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    fetchforceUpdate(setState);
    fetchRelease(setState);
    fetchChartData(setState);
    fetchUsersGuide(setState);
    fetchTermsConditions(setState);
    fetchOnlinePayment(setState);
    fetcCurrentPrice(setState);
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    int hours = now.hour;

    if (hours >= 6 && hours <= 17) {
      setState(() {});
    } else if (hours >= 18 && hours <= 5) {
      setState(() {});
    }
    if (forceUpdate == true) {
      return ForceUpdate();
    } else {
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
                return Center(
                  child: Lottie.asset('assets/lottie/animation_loading.json',
                      width: 100, height: 100),
                );
              } else {
                return Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: VStack([
                      Container(
                        padding: EdgeInsets.only(top: 50, bottom: 20),
                        width: double.infinity,
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
                              ], // Define your gradient colors here
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 20),
                                hours >= 6 && hours <= 17
                                    ? Row(
                                        children: [
                                          Image.asset(
                                              'assets/icons8-partly-cloudy-day-96.png',
                                              height: 30,
                                              width: 30),
                                          Text(
                                            '  Hello, have a great Day!',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w100),
                                          )
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Image.asset(
                                              'assets/icons8-night-96.png',
                                              height: 30,
                                              width: 30),
                                          Text(
                                            '  Hello, have a great Evening!',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w100),
                                          )
                                        ],
                                      ),
                                Spacer(),
                                IconButton(
                                    icon: Icon(
                                        brightness == Brightness.light
                                            ? Icons.light_mode
                                            : Icons.dark_mode,
                                        color: Colors.white),
                                    onPressed: () {}),
                                Icon(
                                  Icons.notifications,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 20),
                              ],
                            ),
                            releaseMode == false
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: brightness == Brightness.light
                                            ? Colors.white
                                            : Colors.white.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(children: [
                                            Text("Bills to Pay",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: brightness ==
                                                            Brightness.light
                                                        ? AppColor.primaryColor
                                                        : Colors.white))
                                          ]),
                                          Row(
                                            children: [
                                              Image.asset(
                                                'assets/icons8-peso-100.png',
                                                scale: 4,
                                                color: brightness ==
                                                        Brightness.light
                                                    ? AppColor.primaryColor
                                                    : Colors.white,
                                              ),
                                              Text(
                                                  "${snapshot.data['balance_to_pay']}",
                                                  style: TextStyle(
                                                      fontSize: 40,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: brightness ==
                                                              Brightness.light
                                                          ? AppColor
                                                              .primaryColor
                                                          : Colors.white)),
                                              Spacer(),
                                              SizedBox(
                                                height: 25,
                                                child: ElevatedButton(
                                                  onPressed: () async {
                                                    Navigator.of(context)
                                                        .push(_toPayPage());
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    onPrimary: Colors.white,
                                                    primary:
                                                        AppColor.primaryColor,
                                                    onSurface: Colors.grey,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Pay",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                  )
                                : SizedBox()
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 0, top: 5, left: 0, bottom: 20),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              SizedBox(width: 20),
                              GestureDetector(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: brightness == Brightness.light
                                            ? AppColor.primaryColorLight
                                            : Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Image.asset(
                                        "assets/icons8-bill.png",
                                        scale: 2.5,
                                        color: brightness == Brightness.light
                                            ? AppColor.primaryColor
                                            : Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Bills",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                onTap: () async {
                                  Navigator.of(context).push(_toBills());
                                },
                              )
                                  .animate()
                                  .fadeIn()
                                  .move(delay: 50.ms, duration: 100.ms),
                              SizedBox(width: 20),
                              GestureDetector(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: brightness == Brightness.light
                                            ? AppColor.primaryColorLight
                                            : Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Image.asset(
                                        "assets/analytics_icon.png",
                                        scale: 2.5,
                                        color: brightness == Brightness.light
                                            ? AppColor.primaryColor
                                            : Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Analytics",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                onTap: () async {
                                  Navigator.of(context).push(_toAnalytics());
                                },
                              )
                                  .animate()
                                  .fadeIn()
                                  .move(delay: 100.ms, duration: 100.ms),
                              SizedBox(width: 20),
                              GestureDetector(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: brightness == Brightness.light
                                            ? AppColor.primaryColorLight
                                            : Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Image.asset(
                                        "assets/log_icon.png",
                                        scale: 3.5,
                                        color: brightness == Brightness.light
                                            ? AppColor.primaryColor
                                            : Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Transactions",
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                                onTap: () {
                                  Navigator.of(context).push(_toTransaction());
                                },
                              )
                                  .animate()
                                  .fadeIn()
                                  .move(delay: 100.ms, duration: 200.ms),
                              SizedBox(width: 20),
                              GestureDetector(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        // ignore: unrelated_type_equality_checks
                                        color: brightness == Brightness.light
                                            ? AppColor.primaryColorLight
                                            : Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Image.asset(
                                          "assets/water_drop.png",
                                          scale: 3,
                                          color: brightness == Brightness.light
                                              ? AppColor.primaryColor
                                              : Colors.white),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Price rate",
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                                onTap: () {
                                  Navigator.of(context).push(_toPriceRate());
                                },
                              )
                                  .animate()
                                  .fadeIn()
                                  .move(delay: 100.ms, duration: 300.ms),
                              SizedBox(width: 30),
                              GestureDetector(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        // ignore: unrelated_type_equality_checks
                                        color: brightness == Brightness.light
                                            ? AppColor.primaryColorLight
                                            : Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Image.asset(
                                        "assets/icons8-customer-support-90.png",
                                        scale: 2.5,
                                        color: brightness == Brightness.light
                                            ? AppColor.primaryColor
                                            : Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Support",
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                                onTap: () {
                                  Navigator.of(context).push(_toSupportPage());
                                },
                              )
                                  .animate()
                                  .fadeIn()
                                  .move(delay: 100.ms, duration: 400.ms),
                              SizedBox(width: 20),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(width: 10),
                          Text(
                            "News & Updates",
                            style: GoogleFonts.nunitoSans(
                                fontSize: 15, fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Divider(),
                      ),
                      SizedBox(
                        height: releaseMode == true ? 500 : 400,
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
                              return Center(
                                child: Lottie.asset(
                                    'assets/lottie/animation_loading.json',
                                    width: 100,
                                    height: 100),
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
                            return AnimationLimiter(
                              child: ListView(
                                physics: snapshot.data!.size <= 4
                                    ? NeverScrollableScrollPhysics()
                                    : BouncingScrollPhysics(),
                                padding: EdgeInsets.only(top: 0),
                                children: snapshot.data!.docs
                                    .map((DocumentSnapshot document) {
                                  Map<String, dynamic> data =
                                      document.data()! as Map<String, dynamic>;
                                  return AnimationConfiguration.staggeredList(
                                    position: snapshot.data!.size,
                                    delay: Duration(milliseconds: 200),
                                    child: SlideAnimation(
                                      duration: Duration(milliseconds: 2500),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      child: FadeInAnimation(
                                        curve: Curves.fastLinearToSlowEaseIn,
                                        duration: Duration(milliseconds: 2500),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5, bottom: 10),
                                          child: Card(
                                            shadowColor:
                                                Color.fromARGB(255, 34, 34, 34),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Narra Water Supply System',
                                                        maxLines: 1,
                                                        softWrap: false,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        data['date'],
                                                        maxLines: 1,
                                                        softWrap: false,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w200),
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
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          data['descriptions'],
                                                          maxLines: 3,
                                                          softWrap: false,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w200),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
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
  }

  Route _toPayPage() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, anotherAnimation) => PayPage(),
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
            child: PayPage());
      },
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

  Route _toBills() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, anotherAnimation) => BillsPage(),
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
            child: BillsPage());
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

  Route _toSupportPage() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, anotherAnimation) => SupportPage(),
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
            child: SupportPage());
      },
    );
  }
}
