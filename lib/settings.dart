//import 'dart:html';
//import 'dart:js';

import 'package:flutter/material.dart';
import './language.dart';
import './devices.dart';
import './business.dart';
import './displayTheme.dart';
import './withdraw.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  List settingsList = [
    {
      "title": "Business Details",
      "subtitle": "Shop name and location",
      "icon": 0xf3ef,
      "page": 1
    },
    {
      "title": "Language",
      "subtitle": "Change language",
      "icon": 0xf45e,
      "page": 2
    },
    {
      "title": "Theme",
      "subtitle": "Dark and light theme",
      "icon": 0xef9f,
      "page": 3
    },
    {
      "title": "Withdraw",
      "subtitle": "Select withdrawal method",
      "icon": 0xee33,
      "page": 4
    },
    {
      "title": "Devices",
      "subtitle": "Connect web devices",
      "icon": 0xf6a8,
      "page": 5
    },
    {
      "title": "Help and Support",
      "subtitle": "Discuss about problems and bugs",
      "icon": 0xf01f5,
      "page": 6
    },
    {
      "title": "About Agami Merchant",
      "subtitle": "Terms and conditions",
      "icon": 0xf0376,
      "page": 7
    },
    {
      "title": "Logout",
      "subtitle": "Keep account secure",
      "icon": 0xf88b,
      "page": 8
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Roboto Condensed',
                      fontSize: 22,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_outlined),
                    color: Colors.white,
                  )
                ],
              ),
            ),
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                const CircleAvatar(
                  radius: 80,
                  backgroundImage:
                      NetworkImage('https://i.ibb.co/stQv06t/unnamed.jpg'),
                  backgroundColor: Color(0xFF181D5A),
                ),
                CircleAvatar(
                  backgroundColor: const Color(0xFF434B96),
                  child: IconButton(
                    onPressed: () {},
                    splashRadius: 20,
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xFF181D5A),
              ),
              child: Column(
                children: [
                  for (var options in settingsList)
                    InkWell(
                      onTap: () => _handleNavigation(options['page']),
                      child: Wrap(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  IconData(options['icon'],
                                      fontFamily: 'MaterialIcons'),
                                  color: Colors.white,
                                  size: 22,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          options['title'],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Roboto Condensed',
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          options['subtitle'],
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontFamily: 'Roboto Condensed',
                                            fontSize: 14,
                                          ),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible:
                                options == settingsList[settingsList.length - 1]
                                    ? false
                                    : true,
                            child: const Divider(
                              color: Color(0xFF050933),
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _handleNavigation(key) {
    switch (key) {
      case 1:
        {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Business(),
            ),
          );
        }
        break;
      case 2:
        {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Language(),
            ),
          );
        }
        break;
      case 3:
        {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const DisplayTheme(),
            ),
          );
        }
        break;
      case 4:
        {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Withdraw(),
            ),
          );
        }
        break;
      case 5:
        {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Devices(),
            ),
          );
        }
        break;
      case 6:
        {}
        break;
      case 7:
        {}
        break;
      case 8:
        {}
        break;
    }
  }
}
