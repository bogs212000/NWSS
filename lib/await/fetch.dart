import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nwss/constants/const.dart';
import 'package:paymongo_sdk/paymongo_sdk.dart';

Future<void> calculateTotalAmount(Function(void Function()) setState) async {
  double totalAmount = 0;

  // Query the collection to get all documents
  QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
      .instance
      .collection("Accounts")
      .doc(account_ID)
      .collection("bills")
      .doc("2023")
      .collection("month")
      .get();

  // Iterate through the documents and sum up the amounts
  for (QueryDocumentSnapshot<Map<String, dynamic>> document
      in querySnapshot.docs) {
    // Check if the document data contains the 'amount' key
    if (document.data().containsKey('bills')) {
      // Get the 'amount' field from the document data and add it to the total
      totalAmount += (document.data()['bills'] as num).toDouble();
    }
  }

  // Print the total amount
  print('Total amount: $totalAmount');

  // Update the state using the provided setState function
  setState(() {
    totalBalance =
        totalAmount; // Assuming totalBalance is a variable in the widget's state
  });
}

Future<void> fetchAccountID(Function setState) async {
  try {
    final snapshot =
        await FirebaseFirestore.instance.collection('user').doc(email).get();

    account_ID = snapshot.data()?['account_ID'];

    setState(() {
      account_ID = account_ID;
    });
    print('$account_ID, account ID');
  } catch (e) {
    // Handle errors
  }
}

Future<void> fetchGcashNum(Function setState) async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('App Settings')
        .doc("Gcash")
        .get();

    gcashNum = snapshot.data()?['Number'];

    setState(() {
      gcashNum = gcashNum;
    });
    print('$gcashNum, Gcash Number');
  } catch (e) {
    // Handle errors
  }
}

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

Future<void> fetchUserFullname(Function setState) async {
  try {
    final snapshot =
        await FirebaseFirestore.instance.collection('user').doc(email).get();

    fullname = snapshot.data()?['fullname'];

    setState(() {
      fullname = fullname;
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

Future<String> createCheckoutSession() async {
  final String apiKey =
      'sk_test_G81qsqBmSjH139G4WLo41biH'; // Replace with your actual secret API key
  final String apiUrl = 'https://api.paymongo.com/v1/checkout_sessions';

  final String encodedApiKey = base64.encode(utf8.encode('$apiKey:'));

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Basic $encodedApiKey',
  };

  final Map<String, dynamic> requestData = {
    'data': {
      'attributes': {
        'amount': (bills! * 100).floor(),
        // Convert to integer representing cents
        'payment_method_allowed': ['gcash'],
        // Specify allowed payment method
        'payment_method_types': ['gcash'],
        // Specify allowed payment method types
        'line_items': [
          {
            'name': 'Bills',
            // Replace with actual product name
            'quantity': 1,
            // Replace with actual quantity
            'amount': (bills! * 100).floor(),
            // Convert to integer representing cents
            'currency': 'PHP',
            // Replace with actual currency code
            // Add other line item details as needed
          }
        ],
        'send_email_receipt': true,
      }
    }
  };

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: headers,
    body: jsonEncode(requestData),
  );

  if (response.statusCode == 201) {
    final responseData = jsonDecode(response.body);
    return responseData['data']['url'];
  } else if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    final checkoutUrl =
        responseData['data']['attributes']['checkout_url'] as String?;
    if (checkoutUrl != null) {
      print('haha');
      return checkoutUrl;
    } else {
      throw Exception('Checkout URL is null or empty in the response.');
    }
  } else {
    throw Exception(
        'Failed to create checkout session. Status code: ${response.statusCode}. Response body: ${response.body}');
  }
}

Future<String> createPaymentSession() async {
  final String apiKey = 'sk_test_G81qsqBmSjH139G4WLo41biH'; // Replace with your actual secret API key
  final String apiUrl = 'https://api.paymongo.com/v1/payment_intents';

  final String encodedApiKey = base64.encode(utf8.encode('$apiKey:'));

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Basic $encodedApiKey',
  };

  final Map<String, dynamic> requestData = {
    'data': {
      'attributes': {
        'amount': (bills! * 100).floor(),
        // Convert to integer representing cents
        'currency': 'PHP', // Specify the currency code (e.g., PHP for Philippine Peso)
        'payment_method_allowed': ['gcash'],
        // Specify allowed payment method
        'payment_method_types': ['gcash'],
        // Specify allowed payment method types
        'description': 'Payment for Bills', // Add a description for the payment
        'statement_descriptor': 'Bills Payment', // Add a statement descriptor for the payment
        // Add other attributes as needed
      }
    }
  };

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: headers,
    body: jsonEncode(requestData),
  );

  if (response.statusCode == 201) {
    final responseData = jsonDecode(response.body);
    return responseData['data']['attributes']['client_secret'];
  } else {
    throw Exception(
        'Failed to create payment session. Status code: ${response.statusCode}. Response body: ${response.body}');
  }
}





Future<void> initiatePayment() async {
  try {
    Map<String, dynamic> paymentResponse = await PayMongoApi.createPayment(
      amount: bills.toString(),
      paymentMethodId: 'test',
    );

    // Handle the payment response here
    bool paymentSuccessful =
        paymentResponse['data']['attributes']['status'] == 'paid';

    if (paymentSuccessful) {
      // _showPaymentSuccess();
    } else {
      // _showPaymentError();
    }
  } catch (e) {
    print('Error initiating payment: $e');
    // _showPaymentError();
  }
}

class PayMongoApi {
  static const String _baseUrl = 'https://api.paymongo.com/v1';
  static const String _apiKey =
      'sk_test_2fsdysiyphUYGPJomZrbX17d'; // Replace with your actual PayMongo API key

  static Future<Map<String, dynamic>> createPayment({
    required String amount,
    required String paymentMethodId,
  }) async {
    try {
      Map<String, dynamic> requestBody = {
        'data': {
          'attributes': {
            'amount': amount,
            'payment_method': paymentMethodId,
          },
          'type': 'payments',
        },
      };

      final response = await http.post(
        Uri.parse('$_baseUrl/payments'),
        headers: {
          'Authorization': 'Basic $_apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed to create payment: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to create payment: $e');
    }
  }
}
