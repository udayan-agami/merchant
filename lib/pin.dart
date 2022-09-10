import 'dart:convert';

import 'package:agami/home.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

var box = Hive.box('agamiMerchant');
var token1 = box.get('token1');

class Pin extends StatefulWidget {
  const Pin({Key? key}) : super(key: key);

  @override
  State<Pin> createState() => _PinState();
}

class _PinState extends State<Pin> {
  var enteredPin = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBC100),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.lock_reset_outlined,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.logout_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'Secret PIN',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Roboto Condensed',
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(20, 0, 0, 0),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: Icon(
                            Icons.circle,
                            color: enteredPin.length >= 1
                                ? Color.fromARGB(110, 0, 0, 0)
                                : Colors.transparent,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(20, 0, 0, 0),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: Icon(
                            Icons.circle,
                            color: enteredPin.length >= 2
                                ? Color.fromARGB(110, 0, 0, 0)
                                : Colors.transparent,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(20, 0, 0, 0),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: Icon(
                            Icons.circle,
                            color: enteredPin.length >= 3
                                ? Color.fromARGB(110, 0, 0, 0)
                                : Colors.transparent,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(20, 0, 0, 0),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: Icon(
                            Icons.circle,
                            color: enteredPin.length >= 4
                                ? Color.fromARGB(110, 0, 0, 0)
                                : Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'Secret PIN',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Roboto Condensed',
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
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
                              color: Color.fromARGB(20, 0, 0, 0),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Text(
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
                              color: Color.fromARGB(20, 0, 0, 0),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Text(
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
                              color: Color.fromARGB(20, 0, 0, 0),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Text(
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
                              color: Color.fromARGB(20, 0, 0, 0),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Text(
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
                              color: Color.fromARGB(20, 0, 0, 0),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Text(
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
                              color: Color.fromARGB(20, 0, 0, 0),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Text(
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
                              color: Color.fromARGB(20, 0, 0, 0),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Text(
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
                              color: Color.fromARGB(20, 0, 0, 0),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Text(
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
                              color: Color.fromARGB(20, 0, 0, 0),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Text(
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
                              color: Color.fromARGB(20, 0, 0, 0),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Icon(
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
                              color: Color.fromARGB(20, 0, 0, 0),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Text(
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
                          onTap: _verifyPin,
                          child: Container(
                            height: 70,
                            width: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(20, 0, 0, 0),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Icon(
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

  void _verifyPin() async {
    var url =
        'https://agami-merchant.udayanbasak1.repl.co/verifypin?pin=$enteredPin&token1=$token1';

    final uri = Uri.parse(url);
    if (enteredPin.length == 4) {
      final response = await http.get(uri);
      final body = response.body;
      final json = jsonDecode(body);
      if (json['error'] == false) {
        box.put('token2', json['token2']);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      } else {
        setState(() {});
      }
    }
  }
}
