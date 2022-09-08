import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './sign.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), _navigateToSign);
  }

  _navigateToSign() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Sign(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFc89154),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.35,
                  width: MediaQuery.of(context).size.width * 0.35,
                  constraints: const BoxConstraints(
                    maxWidth: 150,
                    maxHeight: 150,
                  ),
                  child: SvgPicture.asset('agami_logo.svg'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
