import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nwss/constants/const.dart';

Future<void> fetchOnlinePayment(Function setState) async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('App Settings')
        .doc('OnlinePayment')
        .get();
    onlinePayment = snapshot.data()?['set'];
    setState(() {
      onlinePayment = onlinePayment;
    });
  } catch (e) {
    // Handle errors
  }
}

