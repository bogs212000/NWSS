import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nwss/constants/app_colors.dart';
import 'package:nwss/pages/home.dart';

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
        centerTitle: true,
        title: Text(
          "NWSS",
          style: GoogleFonts.ptSans(
              fontWeight: FontWeight.bold, color: AppColor.white),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(
              Icons.settings,
              size: 30,
              color: Colors.amber,
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: AppColor.primaryColor,
        foregroundColor: Colors.amber,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
              ),
              child: Column(
                children: [

                ],
              ),
            ),
          ],
        ),
      ),
      body: _myPages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        height: 60.0,
        items: const [
          Icon(Icons.call, color: Colors.white),
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.featured_play_list_rounded, color: Colors.white),
          Icon(Icons.chat, color: Colors.white),
        ],
        color: AppColor.primaryColor,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
