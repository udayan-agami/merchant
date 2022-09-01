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
      "subtitle": "Shop name and location",
      "icon": 0xf3ef,
      "key": 0
    },
    {
      "title": "Language",
      "subtitle": "Change language",
      "icon": 0xf45e,
      "key": 1
    },
    {
      "title": "Notifications",
      "subtitle": "Get updates at a glance",
      "icon": 0xf0027,
      "key": 2
    },
    {
      "title": "Withdraw",
      "subtitle": "Select withdrawal method",
      "icon": 0xee33,
      "key": 3
    },
    {
      "title": "Devices",
      "subtitle": "Connect web devices",
      "icon": 0xf6a8,
      "key": 4
    },
    {
      "title": "Help and Support",
      "subtitle": "Discuss about problems and bugs",
      "icon": 0xf01f5,
      "key": 5
    },
    {
      "title": "About Agami Merchant",
      "subtitle": "Terms and conditions",
      "icon": 0xf0376,
      "key": 6
    },
    {
      "title": "Logout",
      "subtitle": "Keep account secure",
      "icon": 0xf88b,
      "key": 7
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
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xFF181D5A),
              ),
              child: Column(
                children: [
                  for (var options in settingsList)
                    Wrap(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                        Visibility(
                          visible: options['key'] == settingsList.length - 1
                              ? false
                              : true,
                          child: Divider(
                            color: const Color(0xFF050933),
                            thickness: 1,
                          ),
                        ),
                      ],
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
