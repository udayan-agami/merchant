import 'package:flutter/material.dart';

class DisplayTheme extends StatefulWidget {
  const DisplayTheme({Key? key}) : super(key: key);

  @override
  State<DisplayTheme> createState() => _DisplayThemeState();
}

class _DisplayThemeState extends State<DisplayTheme> {
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
                    PopupMenuButton(
                      color: const Color(0xFF434B96),
                      padding: EdgeInsets.all(0),
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                        size: 22,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      tooltip: 'Theme',
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: ListTile(
                            leading: Icon(
                              Icons.notifications_active_outlined,
                              color: Colors.white,
                            ),
                            title: Text(
                              'Active notification',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto Condensed',
                              ),
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          child: ListTile(
                            leading: Icon(
                              Icons.check_circle_outline,
                              color: Colors.white,
                            ),
                            title: Text(
                              'Mark all as read',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto Condensed',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
