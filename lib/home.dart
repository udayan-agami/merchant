//import 'dart:ui';
import 'package:flutter/services.dart';
import './dashboard.dart';
import './history.dart';
import './settings.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

var box = Hive.box('agamiMerchant');

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
  var selectedLanguage = box.get('language', defaultValue: 1);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
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
                    _pageController.animateToPage(index,
                        duration: const Duration(microseconds: 1000),
                        curve: Curves.easeIn);
                  });
                },
                textStyle: const TextStyle(
                    fontFamily: 'Roboto Condensed, Ador Noirrit',
                    color: Colors.white),
                tabs: [
                  GButton(
                    icon: Icons.featured_play_list_outlined,
                    text: selectedLanguage == 1 ? 'History' : 'ইতিবৃত্ত',
                    iconColor: Theme.of(context).hintColor,
                    iconActiveColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                  ),
                  GButton(
                    icon: Icons.space_dashboard_outlined,
                    text: selectedLanguage == 1 ? 'Dashboard' : 'ড্যাশবোর্ড',
                    iconColor: Theme.of(context).hintColor,
                    iconActiveColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                  ),
                  GButton(
                    icon: Icons.admin_panel_settings_outlined,
                    text: selectedLanguage == 1 ? 'Settings' : 'বিন্যাস',
                    iconColor: Theme.of(context).hintColor,
                    iconActiveColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
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
          children: const [History(), Dashboard(), Settings()],
        ));
  }
}
