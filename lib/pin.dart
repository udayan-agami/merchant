import 'dart:convert';
import 'package:agami/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import './Splashscreen.dart';
import 'package:url_launcher/url_launcher.dart';

var box = Hive.box('agamiMerchant');

class Pin extends StatefulWidget {
  const Pin({Key? key}) : super(key: key);

  @override
  State<Pin> createState() => _PinState();
}

class _PinState extends State<Pin> {
  var _auth = FirebaseAuth.instance;
  var enteredPin = '';
  var pinLabel = 'Enter PIN';
  var selectedLanguage = box.get('language', defaultValue: 1);
  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).primaryColorDark,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Theme.of(context).primaryColorDark,
    );
    SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () async {
                      await launchUrl(Uri.parse('tel://+8801974766899'));
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColorDark,
                      side: BorderSide(
                        width: 1,
                        color: Theme.of(context).hintColor,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Text(
                      'Help',
                      style: TextStyle(
                        fontFamily: 'Roboto Condensed Ador Noirrit',
                        fontSize: 12,
                        color: Theme.of(context).highlightColor,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      final FirebaseAuth _auth = FirebaseAuth.instance;
                      await _auth.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SplashScreen(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColorDark,
                      side: BorderSide(
                        width: 1,
                        color: Theme.of(context).hintColor,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        fontFamily: 'Roboto Condensed Ador Noirrit',
                        fontSize: 12,
                        color: Theme.of(context).highlightColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: Container(
                height: 1000,
                child: Image.asset(
                  './assets/pin-back.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
              ),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(78, 255, 255, 255),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: Icon(
                              Icons.circle,
                              color: enteredPin.length >= 1
                                  ? const Color.fromARGB(110, 0, 0, 0)
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(78, 255, 255, 255),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: Icon(
                              Icons.circle,
                              color: enteredPin.length >= 2
                                  ? const Color.fromARGB(110, 0, 0, 0)
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(78, 255, 255, 255),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: Icon(
                              Icons.circle,
                              color: enteredPin.length >= 3
                                  ? const Color.fromARGB(110, 0, 0, 0)
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(78, 255, 255, 255),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: Icon(
                              Icons.circle,
                              color: enteredPin.length >= 4
                                  ? const Color.fromARGB(110, 0, 0, 0)
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Chip(
                      backgroundColor: Theme.of(context).primaryColor,
                      side: BorderSide(
                        width: 1,
                        color: Theme.of(context).primaryColor,
                        style: BorderStyle.solid,
                      ),
                      label: Text(
                        pinLabel,
                        style: TextStyle(
                          color: Theme.of(context).highlightColor,
                          fontFamily: 'Roboto Condensed',
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () => _tapButton('1'),
                          child: Container(
                            height: 70,
                            width: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(20, 0, 0, 0),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Text(
                              selectedLanguage == 1 ? '1' : '১',
                              style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontSize: 22,
                                fontFamily: 'Roboto Condensed, Ador Noirrit',
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _tapButton('2'),
                          child: Container(
                            height: 70,
                            width: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(20, 0, 0, 0),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Text(
                              selectedLanguage == 1 ? '2' : '২',
                              style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontSize: 22,
                                fontFamily: 'Roboto Condensed, Ador Noirrit',
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _tapButton('3'),
                          child: Container(
                            height: 70,
                            width: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(20, 0, 0, 0),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Text(
                              selectedLanguage == 1 ? '3' : '৩',
                              style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontSize: 22,
                                fontFamily: 'Roboto Condensed, Ador Noirrit',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () => _tapButton('4'),
                          child: Container(
                            height: 70,
                            width: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(20, 0, 0, 0),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Text(
                              selectedLanguage == 1 ? '4' : '৪',
                              style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontSize: 22,
                                fontFamily: 'Roboto Condensed, Ador Noirrit',
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _tapButton('5'),
                          child: Container(
                            height: 70,
                            width: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(20, 0, 0, 0),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Text(
                              selectedLanguage == 1 ? '5' : '৫',
                              style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontSize: 22,
                                fontFamily: 'Roboto Condensed, Ador Noirrit',
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _tapButton('6'),
                          child: Container(
                            height: 70,
                            width: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(20, 0, 0, 0),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Text(
                              selectedLanguage == 1 ? '6' : '৬',
                              style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontSize: 22,
                                fontFamily: 'Roboto Condensed, Ador Noirrit',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () => _tapButton('7'),
                          child: Container(
                            height: 70,
                            width: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(20, 0, 0, 0),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Text(
                              selectedLanguage == 1 ? '7' : '৭',
                              style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontSize: 22,
                                fontFamily: 'Roboto Condensed, Ador Noirrit',
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _tapButton('8'),
                          child: Container(
                            height: 70,
                            width: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(20, 0, 0, 0),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Text(
                              selectedLanguage == 1 ? '8' : '৮',
                              style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontSize: 22,
                                fontFamily: 'Roboto Condensed, Ador Noirrit',
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _tapButton('9'),
                          child: Container(
                            height: 70,
                            width: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(20, 0, 0, 0),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Text(
                              selectedLanguage == 1 ? '9' : '৯',
                              style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontSize: 22,
                                fontFamily: 'Roboto Condensed, Ador Noirrit',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              enteredPin = '';
                            });
                          },
                          child: Container(
                            height: 70,
                            width: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(20, 0, 0, 0),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Icon(
                              Icons.backspace_outlined,
                              color: Theme.of(context).highlightColor,
                              size: 18,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _tapButton('0'),
                          child: Container(
                            height: 70,
                            width: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(20, 0, 0, 0),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Text(
                              selectedLanguage == 1 ? '0' : '০',
                              style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontSize: 22,
                                fontFamily: 'Roboto Condensed, Ador Noirrit',
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            _verifyPin(context);
                          },
                          child: Container(
                            height: 70,
                            width: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(20, 0, 0, 0),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Icon(
                              Icons.done_outlined,
                              color: Theme.of(context).highlightColor,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _tapButton(dig) {
    if (enteredPin.length < 4) {
      setState(() {
        enteredPin = enteredPin + dig;
      });
    }
  }

  void _verifyPin(context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Name, email address, and profile photo URL
      final phoneNumber = user.phoneNumber;
      var url =
          'https://us-central1-amardokan-5e0da.cloudfunctions.net/app/pin?pin=$enteredPin&phone=$phoneNumber';
      final uri = Uri.parse(url);
      if (enteredPin.length == 4) {
        final response = await http.get(uri);
        final body = response.body;
        final json = jsonDecode(body);
        if (json['error'] == 0) {
          box.put('token', json['token']);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (ctx) => const Home(),
            ),
          );
        } else {
          setState(() {
            enteredPin = '';
            pinLabel = json['message'];
          });
        }
      }
    }
  }
}
