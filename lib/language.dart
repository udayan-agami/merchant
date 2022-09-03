import 'dart:ui';

import 'package:flutter/material.dart';

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  int language = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050933),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF181D5A),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.undo,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const Text(
                    'Language Settings',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Roboto Condensed',
                      fontSize: 22,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  language = 2;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: language == 2
                      ? const Color(0xFF434B96)
                      : const Color(0xFF181D5A),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                ),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        language == 2
                            ? Icons.task_alt_rounded
                            : Icons.radio_button_unchecked_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'বাংলা',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Roboto Condensed, Ador Noirrit'),
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  language = 1;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: language == 1
                      ? const Color(0xFF434B96)
                      : const Color(0xFF181D5A),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(15),
                  ),
                ),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.fromLTRB(20, 2, 20, 10),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        language == 1
                            ? Icons.task_alt_rounded
                            : Icons.radio_button_unchecked_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'English',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Roboto Condensed'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
