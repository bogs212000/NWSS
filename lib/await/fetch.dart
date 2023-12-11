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

Future<void> fetcCurrentPrice(Function setState) async {
  try {
    final snapshot =
        await FirebaseFirestore.instance.collection('price').doc('price').get();

    currentPrice = snapshot.data()?['current'];

    setState(() {
      releaseMode = releaseMode;
    });
  } catch (e) {
    // Handle errors
  }
}

Future<void> fetchforceUpdate(Function setState) async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('App Settings')
        .doc('Control')
        .get();

    // Check if the document exists and has the 'force update' field
    if (snapshot.exists && snapshot.data() != null) {
      forceUpdate = snapshot.data()?['force update'];

      setState(() {
        forceUpdate = forceUpdate;
      });
      print(forceUpdate.toString());
    } else {
      // Handle the case where the document or the field does not exist
      print('Document or field not found');
    }
  } catch (e) {
    // Handle errors
    print('Error fetching force update: $e');
  }
}
