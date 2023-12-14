// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nwss/await/fetch.dart';
import 'package:nwss/constants/app_colors.dart';
import 'package:nwss/constants/const.dart';
import 'package:shimmer/shimmer.dart';

class PriceRate extends StatefulWidget {
  const PriceRate({super.key});

  @override
  State<PriceRate> createState() => _PriceRateState();
}

class _PriceRateState extends State<PriceRate> {
  @override
  void initState() {
    super.initState();
    fetcCurrentPrice(setState);
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
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
                    brightness == Brightness.light
                        ? Colors.blue.shade500
                        : Colors.blue.shade900,
                    brightness == Brightness.light
                        ? Colors.green.shade300
                        : Colors.green.shade800,
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
                        child: Image.asset("assets/water_drop.png", scale: 3),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Price Rate",
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
            Row(
              children: [
                Lottie.asset('assets/lottie/animation_lo0waq85.json',
                    width: 150, height: 150, repeat: false),
                VerticalDivider(
                  color: Colors.black,
                  thickness: 2,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            'Current water price',
                            maxLines: 2,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 20)
                      ],
                    ),
                    Row(
                      children: [
                        Shimmer.fromColors(
                          period: Duration(milliseconds: 2000),
                          baseColor: AppColor.primaryColor,
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          child: Text(
                            currentPrice.toString(),
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: AppColor.primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ))
              ],
            ),
            SizedBox(
              height: releaseMode == true ? 700 : 400,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("price")
                    .doc('price')
                    .collection("priceUpdateHistory")
                    .orderBy("createdAt", descending: true)
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
                  if (snapshot.connectionState == ConnectionState.waiting) {
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
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
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
                                  shadowColor: Color.fromARGB(255, 34, 34, 34),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: data['changed'] != 'up'
                                            ? Colors.green.withOpacity(0.7)
                                            : Colors.red.withOpacity(0.7),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
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
                                            Text(
                                              data['price'].toString(),
                                              maxLines: 1,
                                              softWrap: false,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold),
                                            ),
                                            Spacer(),
                                            data['changed'] == 'up' ? Icon(Icons.upload) : Icon(Icons.download)
                                          ],
                                        ),

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
          ],
        ),
      ),
    );
  }
}
