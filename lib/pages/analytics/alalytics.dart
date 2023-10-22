import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:nwss/await/loading.dart';
import 'package:nwss/constants/app_colors.dart';
import 'package:nwss/constants/const.dart';

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
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  late   List<ChartBarDataItem> customChartData = [
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
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchChartData();
  }

  Future<void> fetchChartData() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('user')
          .doc(email)
          .collection('usage')
          .doc('2023')
          .get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        double january = data['january'].toDouble();
        double february = data['february'].toDouble();
        double march = data['march'].toDouble();
        double april = data['april'].toDouble();
        double may = data['may'].toDouble();
        double june = data['june'].toDouble();
        double july = data['july'].toDouble();
        double august = data['august'].toDouble();
        double september = data['september'].toDouble();
        double october = data['october'].toDouble();
        double november = data['november'].toDouble();
        double december = data['december'].toDouble();

        setState(() {

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
        });

      } else {
        // Handle the case where the data doesn't exist
      }
    } catch (e) {
      // Handle errors
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.primaryColor,
        foregroundColor: AppColor.white,
      ),
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
            ),
            const SizedBox(height: 0),
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
