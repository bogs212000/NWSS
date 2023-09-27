import 'package:flutter/material.dart';
import 'package:nwss/constants/app_colors.dart';
import 'package:nwss/navigator.dart';
import 'package:nwss/pages/analytics/alalytics.dart';
import 'package:nwss/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'NWSS App',
      theme: ThemeData(),
      home: NavTab(),
    );
  }
}
