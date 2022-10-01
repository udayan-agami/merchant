import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

var box = Hive.box('agamiMerchant');

class DisplayTheme extends StatefulWidget {
  const DisplayTheme({Key? key}) : super(key: key);

  @override
  State<DisplayTheme> createState() => _DisplayThemeState();
}

class _DisplayThemeState extends State<DisplayTheme> {
  List themeList = [
    [
      {"title": "Classic", "color": 0xFFFFFFFF, "object": 0xFFE6E6E6, "id": 1},
      {"title": "Day", "color": 0xFFFFD600, "object": 0xFFCCAb00, "id": 2},
      {"title": "Default", "color": 0xFF181D5A, "object": 0xFF050933, "id": 3},
      {"title": "Night", "color": 0xFF2C3E50, "object": 0xFF233240, "id": 4},
    ],
    [
      {"title": "ক্লাসিক", "color": 0xFFFFFFFF, "object": 0xFFE6E6E6, "id": 1},
      {"title": "লাইট", "color": 0xFFFFD600, "object": 0xFFCCAb00, "id": 2},
      {"title": "ডিফল্ট", "color": 0xFF181D5A, "object": 0xFF050933, "id": 3},
      {"title": "ডার্ক", "color": 0xFF2C3E50, "object": 0xFF233240, "id": 4},
    ],
  ];

  var selectedTheme = box.get('theme', defaultValue: 3);
  var selectedLanguage = box.get('language', defaultValue: 1);
  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).primaryColor,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Theme.of(context).primaryColor,
    );
    SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
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
                        color: Theme.of(context).highlightColor,
                        size: 22,
                      ),
                    ),
                    Text(
                      selectedLanguage == 1 ? 'Theme' : 'থিম',
                      style: TextStyle(
                        color: Theme.of(context).highlightColor,
                        fontFamily: 'Roboto Condensed, Ador Noirrit',
                        fontSize: 22,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.done,
                        color: Theme.of(context).highlightColor,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var theme in themeList[selectedLanguage - 1])
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTheme = theme['id'];
                            });
                            box.put('theme', theme['id']);
                          },
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(8),
                                width: 100,
                                height: 126,
                                decoration: BoxDecoration(
                                  color: Color(theme['color']),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            width: 60,
                                            height: 16,
                                            decoration: BoxDecoration(
                                              color: Color(theme['object']),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            width: 60,
                                            height: 16,
                                            decoration: BoxDecoration(
                                              color: Color(theme['object']),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            width: 60,
                                            height: 16,
                                            decoration: BoxDecoration(
                                              color: Color(theme['object']),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          theme['id'] == selectedTheme
                                              ? Icons
                                                  .radio_button_checked_rounded
                                              : Icons
                                                  .radio_button_unchecked_outlined,
                                          color:
                                              Theme.of(context).highlightColor,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4),
                                child: Text(
                                  theme['title'],
                                  style: TextStyle(
                                    color: Theme.of(context).highlightColor,
                                    fontFamily:
                                        'Roboto Condensed, Ador Noirrit',
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
