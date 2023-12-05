import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nwss/constants/const.dart';

class PayPage extends StatefulWidget {
  const PayPage({super.key});

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        child: onlinePayment == false
            ? Column(
                children: [
                  const SizedBox(height: 20),
                  Lottie.asset('assets/lottie/unavailable.json',
                      height: 200, width: 200),
                  const Padding(
                    padding: EdgeInsets.only(right: 20, left: 20),
                    child: Text(
                      'Unfortunately, online payment is currently unavailable at this time.',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w300),
                    ),
                  )
                ],
              )
            : const Column(
                children: [],
              ),
      ),
    );
  }
}
