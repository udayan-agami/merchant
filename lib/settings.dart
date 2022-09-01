import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  List settingsList = [
    {
      "title": "Business Details",
      "subtitle": "Shop name and Location",
      "icon": 0xf3ef,
      "key": 1
    },
    {
      "title": "Language",
      "subtitle": "Change language",
      "icon": 0xf45e,
      "key": 1
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
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xFF181D5A),
              ),
              child: Column(
                children: [
                  for (var options in settingsList)
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Row(
                        children: [
                          Icon(
                            IconData(options['icon'],
                                fontFamily: 'MaterialIcons'),
                            color: Colors.white,
                            size: 22,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    options['title'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Roboto Condensed',
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    options['subtitle'],
                                    style: TextStyle(
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
