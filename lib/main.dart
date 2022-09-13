import 'package:agami/business.dart';
import 'package:agami/home.dart';
import 'package:agami/settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './Splashscreen.dart';
import './pin.dart';
import './home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyATdUyPRJ8z5r1Lcvy2rn2l6S3XqLZ2rbo",
          authDomain: "amardokan-5e0da.firebaseapp.com",
          databaseURL: "https://amardokan-5e0da.firebaseio.com",
          projectId: "amardokan-5e0da",
          storageBucket: "amardokan-5e0da.appspot.com",
          messagingSenderId: "75571691617",
          appId: "1:75571691617:web:5306f011659d7d4ab02a20",
          measurementId: "G-G1Y3RD49YF"),
    );
  }

  await Hive.initFlutter();
  await Hive.openBox('agamiMerchant');

  runApp(const MyApp());
}

//theme data
ThemeData _themeOne = ThemeData(
  primaryColor: const Color(0xFF181D5A),
  primaryColorDark: const Color(0xFF050933),
  primaryColorLight: const Color(0xFF434B96),
  highlightColor: Colors.white,
  hintColor: Colors.grey,
);
ThemeData _themeTwo = ThemeData(
    primaryColor: const Color(0xFFFbC100),
    primaryColorDark: const Color(0xFFC99a00),
    primaryColorLight: const Color(0xFFDCCD33),
    highlightColor: const Color(0xFF191300),
    hintColor: Color(0xFF644d00));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agami Merchant',
      debugShowCheckedModeBanner: false,
      theme: _themeTwo,
      home: const Home(),
    );
  }
}
