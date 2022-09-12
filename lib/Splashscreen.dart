import 'dart:async';
import 'package:agami/pin.dart';
import 'package:flutter/material.dart';
import './sign.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

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
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Pin(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Sign(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF153b5f),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              './assets/splash-back.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.transparent,
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
                      child: Image.asset('./assets/logo.png'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: const Text(
                  'Powered by AGAMiLabs',
                  style: TextStyle(
                    fontFamily: 'Roboto Condensed',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
