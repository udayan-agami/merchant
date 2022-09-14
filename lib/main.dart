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
import 'package:hive_listener/hive_listener.dart';

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
  primaryColor: const Color(0xFFFFFFFF),
  primaryColorDark: const Color(0xFFE6E6E6),
  primaryColorLight: const Color(0xFFFFFFFF),
  highlightColor: const Color(0xFF494949),
  hintColor: const Color(0xFFACACAC),
  indicatorColor: const Color(0xFF4D850D),
  splashColor: const Color(0xFFC4C4C4),
);
ThemeData _themeTwo = ThemeData(
  primaryColor: const Color(0xFFFFD600),
  primaryColorDark: const Color(0xFFCCAb00),
  primaryColorLight: const Color(0xFFFFDE33),
  highlightColor: const Color(0xFF191500),
  hintColor: const Color(0xFF4C4000),
  indicatorColor: Colors.green,
  splashColor: const Color(0xFFCCAb00),
);
ThemeData _themeThree = ThemeData(
  primaryColor: const Color(0xFF181D5A),
  primaryColorDark: const Color(0xFF050933),
  primaryColorLight: const Color(0xFF434B96),
  highlightColor: Colors.white,
  hintColor: Colors.grey,
  indicatorColor: Colors.lightGreenAccent,
  splashColor: const Color(0xFF434B96),
);
ThemeData _themeFour = ThemeData(
  primaryColor: const Color(0xFF2C3E50),
  primaryColorDark: const Color(0xFF233240),
  primaryColorLight: const Color(0xFF566573),
  highlightColor: const Color(0xFFEAECEE),
  hintColor: const Color(0xFFC0C5CB),
  indicatorColor: Colors.green,
  splashColor: const Color(0xFF808B96),
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return HiveListener(
      box: Hive.box('agamiMerchant'),
      keys: const ['theme'],
      builder: (box) {
        return MaterialApp(
          title: 'Agami Merchant',
          debugShowCheckedModeBanner: false,
          theme: box.get('theme', defaultValue: 3) == 1
              ? _themeOne
              : box.get('theme') == 2
                  ? _themeTwo
                  : box.get('theme') == 4
                      ? _themeFour
                      : _themeThree,
          home: const Home(),
        );
      },
    );
  }
}
