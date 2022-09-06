import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Sign extends StatefulWidget {
  const Sign({Key? key}) : super(key: key);

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  var maskFormatter = new MaskTextInputFormatter(
    mask: '##%##-######',
    filter: {"#": RegExp(r'[0-9]'), "%": RegExp(r'[3-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050933),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ga'),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.white,
                        child: Image.asset('assets/logo.png'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Agami Merchant',
                              style: TextStyle(
                                color: Color(0xFF004FC9),
                                fontSize: 24,
                                fontFamily: 'Roboto Condensed',
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Sign in',
                                  style: TextStyle(
                                    color: Color(0xFF004FC9),
                                    fontSize: 24,
                                    fontFamily: 'Roboto Condensed',
                                  ),
                                ),
                                Text(
                                  ' or ',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 24,
                                    fontFamily: 'Roboto Condensed',
                                  ),
                                ),
                                Text(
                                  'Sign up',
                                  style: TextStyle(
                                    color: Color(0xFF004FC9),
                                    fontSize: 24,
                                    fontFamily: 'Roboto Condensed',
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Divider(
                      thickness: 3,
                      color: Color(0xFF004FC9),
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      helperStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      hintText: '01XXX-XXXXXX',
                      hintStyle: TextStyle(
                        color: Colors.blueGrey,
                        fontFamily: 'Roboto Condensed',
                        fontSize: 18,
                      ),
                      labelText: 'Phone number',
                      labelStyle: TextStyle(
                        fontFamily: 'Roboto Condensed',
                        //fontSize: 16,
                        color: Color(0xFF004FC9),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          color: Color(0xFF004FC9),
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          color: Color(0xFF004FC9),
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    style: TextStyle(
                      color: Color(0xFF004FC9),
                      fontSize: 18,
                      fontFamily: 'Roboto Condensed',
                    ),
                    keyboardType: TextInputType.number,
                    autocorrect: false,
                    cursorColor: Color(0xFF004FC9),
                    inputFormatters: [maskFormatter],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF004FC9),
                          elevation: 0,
                          padding: EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 20,
                          ),
                          minimumSize: const Size.fromHeight(50), // NEW
                        ),
                        child: Text(
                          'NEXT',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto Condensed',
                            fontSize: 16,
                          ),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
