import 'dart:html';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

var box = Hive.box('agamiMerchant');

class Business extends StatefulWidget {
  const Business({Key? key}) : super(key: key);

  @override
  State<Business> createState() => _BusinessState();
}

class _BusinessState extends State<Business> {
  var selectedLanguage = box.get('language', defaultValue: 1);
  @override
  Widget build(BuildContext context) {
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
                      selectedLanguage == 1
                          ? 'Business Details'
                          : 'ব্যবসা পরিচিতি',
                      style: TextStyle(
                        color: Theme.of(context).highlightColor,
                        fontFamily: 'Roboto Condensed, Ador Noirrit',
                        fontSize: 22,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).highlightColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  constraints: BoxConstraints(
                                    maxWidth: MediaQuery.of(context).size.width,
                                    maxHeight:
                                        MediaQuery.of(context).size.height,
                                  ),
                                  child: Wrap(
                                    direction: Axis.vertical,
                                    children: [
                                      Container(
                                        constraints: const BoxConstraints(
                                            maxHeight: 300, maxWidth: 300),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            'https://i.ibb.co/Hnjc3bJ/image.png',
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            selectedLanguage == 1
                                                ? 'Save image'
                                                : 'সংরক্ষণ',
                                            style: TextStyle(
                                              fontFamily: 'Roboto Condensed',
                                              fontSize: 15,
                                              color: Theme.of(context)
                                                  .highlightColor,
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      icon: Icon(
                        Icons.qr_code_outlined,
                        color: Theme.of(context).highlightColor,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                  'https://i.ibb.co/stQv06t/unnamed.jpg'),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ma enterprize and co. Ma enterprize and co. Ma enterprize and co.',
                                    style: TextStyle(
                                      color: Theme.of(context).highlightColor,
                                      fontFamily:
                                          'Roboto Condensed, Ador Noirrit',
                                      fontSize: 18,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Anam Sarkar',
                                    style: TextStyle(
                                      color: Theme.of(context).highlightColor,
                                      fontFamily:
                                          'Roboto Condensed, Ador Noirrit',
                                      fontSize: 14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 0.1,
                        color: Theme.of(context).highlightColor,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context).primaryColorDark,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      selectedLanguage == 1
                                          ? 'Phone number'
                                          : 'মোবাইল নম্বর',
                                      style: TextStyle(
                                        color: Theme.of(context).highlightColor,
                                        fontFamily:
                                            'Roboto Condensed, Ador Noirrit',
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      '01725-523652',
                                      style: TextStyle(
                                        color: Theme.of(context).highlightColor,
                                        fontFamily: 'Roboto Condensed',
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.done_rounded,
                                  color: Theme.of(context).indicatorColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context).primaryColorDark,
                        ),
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Flexible(
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        selectedLanguage == 1
                                            ? 'Address'
                                            : 'ঠিকানা',
                                        style: TextStyle(
                                          color:
                                              Theme.of(context).highlightColor,
                                          fontFamily:
                                              'Roboto Condensed, Ador Noirrit',
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        'AKS tower, Lalmonir hat, Beside choto bridege, Gazipur AKS tower, Lalmonir hat, Beside choto bridege, Gazipur',
                                        style: TextStyle(
                                          color:
                                              Theme.of(context).highlightColor,
                                          fontFamily: 'Roboto Condensed',
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //NID
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context).primaryColorDark,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        selectedLanguage == 1
                                            ? 'Legal documents'
                                            : 'এতদ সম্পর্কীয় দলিলাদি',
                                        style: TextStyle(
                                          color:
                                              Theme.of(context).highlightColor,
                                          fontFamily:
                                              'Roboto Condensed, Ador Noirrit',
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        'NID card not verified',
                                        style: TextStyle(
                                          color:
                                              Theme.of(context).highlightColor,
                                          fontFamily: 'Roboto Condensed',
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.done_rounded,
                                  color: Theme.of(context).indicatorColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
