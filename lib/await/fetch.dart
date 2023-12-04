import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nwss/constants/const.dart';

Future<void> fetchTermsConditions(Function setState) async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('App Settings')
        .doc('Terms and conditions')
        .get();

    termsConditions = snapshot.data()?['Link'];

    setState(() {
      releaseMode = releaseMode;
    });
  } catch (e) {
    // Handle errors
  }
}

Future<void> fetchUsersGuide(Function setState) async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('App Settings')
        .doc('Users Guide')
        .get();

    usersGuide = snapshot.data()?['Link'];

    setState(() {
      releaseMode = releaseMode;
    });
  } catch (e) {
    // Handle errors
  }
}
