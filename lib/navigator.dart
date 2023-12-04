// ignore_for_file: prefer_final_fields, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ff_navigation_bar_plus/ff_navigation_bar_plus.dart';
import 'package:flutter/material.dart';
import 'package:nwss/constants/app_colors.dart';
import 'package:nwss/pages/home.dart';
import 'package:nwss/pages/profile/profile_page.dart';
import 'package:velocity_x/velocity_x.dart';

class NavTab extends StatefulWidget {
  const NavTab({super.key});

  @override
  State<NavTab> createState() => _NavTabState();
}

class _NavTabState extends State<NavTab> {
  static List<Widget> _myPages = <Widget>[

    HomePage(),
    ProfilePage(),

  ];
  int _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      body: _myPages[_selectedIndex],
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: brightness == Brightness.light ? Colors.white : Colors.grey.withOpacity(0.5),
          selectedItemBorderColor: Colors.white,
          selectedItemBackgroundColor: brightness == Brightness.light ? AppColor.primaryColor : Colors.black54,
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: brightness == Brightness.light ? Colors.black : Colors.white,
        ),
        items: [


          FFNavigationBarItem(iconData: Icons.home_outlined, label: 'Home'),

          FFNavigationBarItem(
              iconData: Icons.supervised_user_circle_outlined, label: 'Profile'),
        ],
        selectedIndex: _selectedIndex,
        onSelectTab: (index) {
          setState(() {
            _selectedIndex = index;
          });
          }

      ),
    );
  }
}
