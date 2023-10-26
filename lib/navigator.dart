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
    HomePage(),
    ProfilePage(),

  ];
  int _selectedIndex = 1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     Container(
      //       padding: const EdgeInsets.only(right: 10),
      //       child: Image.asset(
      //         "assets/icons8-user-96.png",
      //         scale: 3,
      //       ),
      //     ),
      //   ],
      //   elevation: 0,
      //   backgroundColor: AppColor.primaryColor,
      //   foregroundColor: Colors.white,
      // ),
      // drawer: Drawer(
      //   child: ListView(
      //     children: [
      //       DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: AppColor.primaryColor,
      //         ),
      //         child: Column(
      //           children: [],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: _myPages[_selectedIndex],
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.white,
          selectedItemBorderColor: Colors.white,
          selectedItemBackgroundColor: AppColor.primaryColor,
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.black,
        ),
        items: [

          FFNavigationBarItem(
              iconData: Icons.chat_outlined, label: 'Message'),
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
