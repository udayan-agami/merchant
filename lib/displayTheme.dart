import 'package:flutter/material.dart';

class DisplayTheme extends StatefulWidget {
  const DisplayTheme({Key? key}) : super(key: key);

  @override
  State<DisplayTheme> createState() => _DisplayThemeState();
}

class _DisplayThemeState extends State<DisplayTheme> {
  List themeList = [
    {"title": "Classic", "color": 0xFFFFC100, "object": 0xFFF44336, "id": 1},
    {"title": "Day", "color": 0xFFFFC100, "object": 0xFFF44336, "id": 2},
    {"title": "Tinted", "color": 0xFFFFC100, "object": 0xFFF44336, "id": 3},
    {"title": "Night", "color": 0xFFFFC100, "object": 0xFFF44336, "id": 4},
  ];
  var selectedTheme = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050933),
      body: SafeArea(
        child: SingleChildScrollView(
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
                      'Theme',
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
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    for (var theme in themeList)
                      GestureDetector(
                        onTap: () => setState(() {
                          selectedTheme = theme['id'];
                        }),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(8),
                              width: 100,
                              height: 126,
                              decoration: BoxDecoration(
                                color: Color(theme['color']),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        theme['id'] == selectedTheme
                                            ? Icons.radio_button_checked_rounded
                                            : Icons
                                                .radio_button_unchecked_outlined,
                                        color: Colors.white,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(4),
                              child: Text(
                                theme['title'],
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontFamily: 'Roboto Condensed',
                                  fontSize: 16,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
