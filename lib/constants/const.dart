import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

String? msg;
bool? loadingLogin;
final fbStore = FirebaseFirestore.instance;
final fbAuth = FirebaseAuth.instance;
String? email = FirebaseAuth.instance.currentUser?.email.toString();