import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nwss/constants/app_colors.dart';
import 'package:nwss/navigator.dart';
import 'package:nwss/pages/analytics/alalytics.dart';
import 'package:nwss/pages/home.dart';

import 'constants/app_theme.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NWSS App',
      theme: ThemeData.light(),
      home: NavTab(),
    );
  }
}
