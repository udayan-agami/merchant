import 'dart:convert';

import 'package:agami/home.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

var box = Hive.box('agamiMerchant');
var token1 = box.get('token1');

class Pin extends StatefulWidget {
  const Pin({Key? key}) : super(key: key);

  @override
  State<Pin> createState() => _PinState();
}

class _PinState extends State<Pin> {
  var enteredPin = '';
  var pinLabel = 'Enter PIN';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 19, 59),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('./assets/pin-back.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(143, 12, 43, 109),
                        Color.fromARGB(255, 1, 19, 59),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
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
                          label: Text(
                            pinLabel,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 12, 42, 109),
                              fontFamily: 'Roboto Condensed',
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 12, 42, 109),
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
                            child: const Text(
                              '1',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontFamily: 'Roboto Condensed',
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
                            child: const Text(
                              '2',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontFamily: 'Roboto Condensed',
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
                            child: const Text(
                              '3',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontFamily: 'Roboto Condensed',
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
                            child: const Text(
                              '4',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontFamily: 'Roboto Condensed',
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
                            child: const Text(
                              '5',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontFamily: 'Roboto Condensed',
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
                            child: const Text(
                              '6',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontFamily: 'Roboto Condensed',
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
                            child: const Text(
                              '7',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontFamily: 'Roboto Condensed',
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
                            child: const Text(
                              '8',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontFamily: 'Roboto Condensed',
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
                            child: const Text(
                              '9',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontFamily: 'Roboto Condensed',
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
                            child: const Icon(
                              Icons.backspace_outlined,
                              color: Colors.white,
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
                            child: const Text(
                              '0',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontFamily: 'Roboto Condensed',
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
                            child: const Icon(
                              Icons.done_outlined,
                              color: Colors.white,
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
