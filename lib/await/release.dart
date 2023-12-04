import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nwss/constants/const.dart';

Future<void> fetchRelease(Function setState) async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('App Settings')
        .doc('release')
        .get();
    releaseMode = snapshot.data()?['releaseMode'];
    setState(() {
      releaseMode = releaseMode;
    });
  } catch (e) {
    // Handle errors
  }
}
