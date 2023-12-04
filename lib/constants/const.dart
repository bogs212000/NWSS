import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

String? msg;
bool? loadingLogin;
final fbStore = FirebaseFirestore.instance;
final fbAuth = FirebaseAuth.instance;
String? email = FirebaseAuth.instance.currentUser?.email.toString();
bool? releaseMode;
String? termsConditions;
String? usersGuide;
DateTime now = DateTime.now();
String formattedDate = DateFormat('EEEE, yyyy-MM-dd').format(now);
String formattedTime = DateFormat('h:mm a').format(now);
String? dayNight = DateFormat('h').format(now);