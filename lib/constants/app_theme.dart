// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:nwss/constants/app_colors.dart';

class AppTheme{

  ThemeData lightTheme(){
    return ThemeData(
      backgroundColor: AppColor.primaryColor,
    );

}
  ThemeData darkTheme(){
    return ThemeData(
        backgroundColor: Colors.black
    );

  }

}