import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

String? msg;
bool? loadingLogin;
final fbStore = FirebaseFirestore.instance;
final fbAuth = FirebaseAuth.instance;
String? email = FirebaseAuth.instance.currentUser?.email.toString();
String? fullname;
String? account_ID;
double? bills;
DateTime? dueDate;
int? amountAfterDue;
int? penalty;
String? dueDateFormated;
String? gcashNum;
String? month;
double? totalBalance;
bool? releaseMode;
bool? onlinePayment;
String? termsConditions;
String? usersGuide;
String role = "client";
double? currentPrice;
bool? forceUpdate;
DateTime now = DateTime.now();
String formattedDate = DateFormat('EEEE, yyyy-MM-dd').format(now);
String formattedTime = DateFormat('h:mm a').format(now);
String? dayNight = DateFormat('h').format(now);
String? checkoutURl;
String? gcashPaymentMethodId;
late BehaviorSubject<double> totalBalanceStream;