// ignore_for_file: prefer_const_constructors, unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nwss/navigator.dart';
import 'package:nwss/pages/auth/auth.wrapper.dart';
import 'package:nwss/pages/auth/login.dart';
import 'package:nwss/pages/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);   
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

     return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            // Remove the debug banner
            debugShowCheckedModeBanner: false,
            title: 'NWSS',
            theme: ThemeData(primarySwatch: Colors.blue, backgroundColor: Colors.green,),
            darkTheme: ThemeData.dark(),
            themeMode: ThemeMode.system,
            home: const SplashPage(),
          );
        });
  }
}

