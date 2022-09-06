import 'package:agami/sign.dart';
import 'package:flutter/material.dart';
import './home.dart';
import './sign.dart';
import './otp.dart';

void main() {
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
      home: const Otp(),
    );
  }
}
