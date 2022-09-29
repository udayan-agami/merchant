import 'package:agami/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

var box = Hive.box('agamiMerchant');

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  var language = box.get('language', defaultValue: 1);
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
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(10),
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
                    language == 1 ? 'Language Settings' : 'ভাষা সম্পাদনা',
                    style: TextStyle(
                      color: Theme.of(context).highlightColor,
                      fontFamily: 'Roboto Condensed, Ador Noirrit',
                      fontSize: 22,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      box.put('language', language);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Home(),
                        ),
                      );
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
            GestureDetector(
              onTap: () {
                setState(() {
                  language = 2;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: language == 2
                      ? Theme.of(context).primaryColorLight
                      : Theme.of(context).primaryColor,
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
                        color: Theme.of(context).highlightColor,
                        size: 24,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'বাংলা',
                        style: TextStyle(
                            color: Theme.of(context).highlightColor,
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
                      ? Theme.of(context).primaryColorLight
                      : Theme.of(context).primaryColor,
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
                        color: Theme.of(context).highlightColor,
                        size: 24,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'English',
                        style: TextStyle(
                            color: Theme.of(context).highlightColor,
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
