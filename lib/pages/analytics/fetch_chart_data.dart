import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nwss/constants/const.dart';

double jan = 0.0;
double feb = 0.0;
double mar = 0.0;
double apr = 0.0;
double ma = 0.0;
double jun = 0.0;
double jul = 0.0;
double aug = 0.0;
double sep = 0.0;
double oct = 0.0;
double nov = 0.0;
double dec = 0.0;

Future<void> fetchChartData(Function setState) async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(email)
        .collection('usage')
        .doc('2023')
        .get();

    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      double january = data['january'].toDouble();
      double february = data['february'].toDouble();
      double march = data['march'].toDouble();
      double april = data['april'].toDouble();
      double may = data['may'].toDouble();
      double june = data['june'].toDouble();
      double july = data['july'].toDouble();
      double august = data['august'].toDouble();
      double september = data['september'].toDouble();
      double october = data['october'].toDouble();
      double november = data['november'].toDouble();
      double december = data['december'].toDouble();

       setState({
      jan = january,
      feb = february,
      mar = march,
      apr = april,
      ma = may,
      jun = june,
      jul = july,
      aug = august,
      sep = september,
      oct = october,
      nov = november,
      dec = december,
    });

    } else {
      // Handle the case where the data doesn't exist
    }
  } catch (e) {
    // Handle errors
  } finally {
   
  }
}
