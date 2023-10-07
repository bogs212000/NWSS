
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:nwss/await/loading.dart';
import 'package:nwss/constants/app_colors.dart';


double jan = 0.0;
double feb = 0.0;
double mar = 0.0;
double apr = 0.0;
double ma = 0.0;
double jun = 0.0;
double jul = 0.0;
double aug = 0.0;
double sep = 0.0;
double oct = 0.0;
double nov = 0.0;
double dec = 0.0;

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {


  List<ChartBarDataItem> customChartData = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.primaryColor,
        foregroundColor: AppColor.white,
      ),
      body: StreamBuilder(stream:  FirebaseFirestore.instance.collection('user').doc('earllontes@gmail.com').collection('usage').doc('2023').snapshots(), 
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
       
        if(snapshot.hasError){
          return LoadingScreen();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingScreen();
        } if (!snapshot.hasData){
           return LoadingScreen();
        } 
        else {
        double january = snapshot.data['january'].toDouble();
         double february = snapshot.data['february'].toDouble();
         double march = snapshot.data['march'].toDouble();
         double april = snapshot.data['april'].toDouble();
         double may = snapshot.data['may'].toDouble();
         double june = snapshot.data['june'].toDouble();
         double july = snapshot.data['july'].toDouble();
         double august = snapshot.data['august'].toDouble();
         double september = snapshot.data['september'].toDouble();
         double october = snapshot.data['october'].toDouble();
         double november = snapshot.data['november'].toDouble();
         double december = snapshot.data['december'].toDouble();
      
        jan = january;
        feb = february;
        mar = march;
        apr = april;
        ma = may;
        jun = june;
        jul = july;
        aug = august;
        sep = september;
        oct = october;
        nov = november;
        dec = december;
  
        return Container(
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
                        max: 500.0,
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
      );
        }
      
       },
       ) 
      
    );
  }
}
