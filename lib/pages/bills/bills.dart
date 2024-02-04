// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nwss/constants/app_colors.dart';
import 'package:nwss/constants/const.dart';

class BillsPage extends StatefulWidget {
  const BillsPage({super.key});

  @override
  State<BillsPage> createState() => _BillsPageState();
}

class _BillsPageState extends State<BillsPage> {
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
                        child:
                            Image.asset("assets/icons8-bill.png", scale: 3.3, color: Colors.blueAccent,),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Bills",
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
            SizedBox(height: 10),
            SizedBox(
              height: 400,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Accounts")
                    .doc(account_ID)
                    .collection('bills').doc("2023").collection("month").where("paid?", isEqualTo: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
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
                      child: Text('No bills yet!'),
                    );
                  }
                  Row(children: const [
                    TextField(
                      decoration: InputDecoration(),
                    )
                  ]);
                  return ListView(
                    physics: snapshot.data!.size <= 4
                        ? NeverScrollableScrollPhysics()
                        : BouncingScrollPhysics(),
                    padding: EdgeInsets.only(top: 10),
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                      return Padding(
                        padding:
                        const EdgeInsets.only(left: 5, right: 5, bottom: 10),
                        child: Card(
                          shadowColor: Color.fromARGB(255, 34, 34, 34),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: GestureDetector( onTap: () {
                            setState(() {
                              bills = data['bills'];
                            });

                          },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        data['month'].toString(),
                                        maxLines: 1,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Spacer(),
                                      Image.asset(
                                        'assets/icons8-peso-100.png',
                                        scale: 4,
                                        color:  Colors.blue,
                                      ),
                                      Text(
                                        data['bills'].toString(),
                                        maxLines: 1,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}



