// ignore_for_file: prefer_final_fields, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:nwss/constants/app_colors.dart';
import 'package:nwss/pages/home.dart';
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
    HomePage(),
    HomePage()
  ];
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Container(
              padding: const EdgeInsets.only(left: 10),
              child: Image.asset(
                "assets/logo.png",
                scale: 2.5,
              ),
            ),
          );
        }),
        title: Column(
          children: [
            Row(
              children: [
                Text("Narra Palawan"),
              ],
            ),
            Row(
              children: [
                Text("Narra Water Supply System", style: TextStyle(fontSize: 10),),
              ],
            ),
          ],
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 10),
            child: Image.asset(
              "assets/icons8-user-96.png",
              scale: 2.5,
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: AppColor.primaryColor,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
              ),
              child: Column(
                children: [],
              ),
            ),
          ],
        ),
      ),
      body: _myPages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        height: 60.0,
        items: [
          Icon(Icons.call, color: AppColor.primaryColor),
          Icon(Icons.home, color: AppColor.primaryColor),
          Icon(Icons.featured_play_list_rounded, color: AppColor.primaryColor),
          Icon(Icons.chat, color: AppColor.primaryColor),
        ],
        color: AppColor.white,
        backgroundColor: AppColor.primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
