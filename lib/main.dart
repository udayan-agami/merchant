import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './Splashscreen.dart';
import './pin.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('agamiMerchant');

  runApp(const MyApp());
}

//theme data
ThemeData _themeOne = ThemeData(
  primaryColor: const Color(0xFF181D5A),
  primaryColorDark: const Color(0xFF050933),
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agami Merchant',
      debugShowCheckedModeBanner: false,
      theme: _themeOne,
      home: const SplashScreen(),
    );
  }
}
