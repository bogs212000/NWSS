import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nwss/constants/app_colors.dart';

class ForceUpdate extends StatefulWidget {
  const ForceUpdate({super.key});

  @override
  State<ForceUpdate> createState() => _ForceUpdateState();
}

class _ForceUpdateState extends State<ForceUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Lottie.asset('assets/lottie/forceUpdate.json'),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 35,
                child: ElevatedButton(
                  onPressed: () async {},
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: AppColor.primaryColor,
                    onSurface: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Update now!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
