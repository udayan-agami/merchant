import 'dart:ui';
import 'package:flutter/services.dart';
import './dashboard.dart';
import './history.dart';
import './settings.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xFF050933),
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarDividerColor: Color(0xFF050933),
  );

  final List transactionList = [];
  int pageIndex = 1;
  PageController _pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    return Scaffold(
        backgroundColor: const Color(0xFF050933),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF434B96),
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: GNav(
                padding: const EdgeInsets.all(5),
                tabBorderRadius: 100,
                iconSize: 28,
                gap: 8,
                selectedIndex: pageIndex,
                tabBackgroundColor: const Color.fromARGB(87, 5, 9, 51),
                onTabChange: (index) {
                  setState(() {
                    pageIndex = index;
                  });
                },
                textStyle: const TextStyle(
                    fontFamily: 'Roboto Condensed', color: Colors.white),
                tabs: const [
                  GButton(
                    icon: Icons.featured_play_list_outlined,
                    text: 'History',
                    iconColor: Colors.blueGrey,
                    iconActiveColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  ),
                  GButton(
                    icon: Icons.space_dashboard_outlined,
                    text: 'Dashboard',
                    iconColor: Colors.blueGrey,
                    iconActiveColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  ),
                  GButton(
                    icon: Icons.admin_panel_settings_outlined,
                    text: 'Settings',
                    iconColor: Colors.blueGrey,
                    iconActiveColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              pageIndex = index;
            });
          },
          children: [History(), Dashboard(), Settings()],
        ));
  }
}
