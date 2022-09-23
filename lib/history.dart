import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:hive/hive.dart';
import 'package:shimmer/shimmer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import './Splashscreen.dart';
import './pin.dart';

var box = Hive.box('agamiMerchant');

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  var selectedLanguage = box.get('language', defaultValue: 1);
  var _isLoading = false;
  var token = box.get('token', defaultValue: 'null');
  Map chips = {
    "payments": true,
    "bills": true,
    "withdraws": true,
    "from": "",
    "to": "",
    "asc": false,
  };
  Map historyCard = {
    "payments": 0,
    "bills": 0,
    "withdraws": 0,
  };
  List transactionList = [];

  @override
  void initState() {
    _handleRefresh();
    chips['from'] =
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';
    chips['to'] =
        '${DateTime.now().subtract(const Duration(days: 30)).day}-${DateTime.now().subtract(const Duration(days: 30)).month}-${DateTime.now().subtract(const Duration(days: 30)).year}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LiquidPullToRefresh(
          color: Theme.of(context).splashColor,
          height: 200,
          backgroundColor: Theme.of(context).primaryColorDark,
          animSpeedFactor: 2,
          showChildOpacityTransition: false,
          onRefresh: _handleRefresh,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //bill basket
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedLanguage == 1
                                  ? 'Bill Basket'
                                  : 'আদেয়ক নথি',
                              style: TextStyle(
                                fontFamily: 'Roboto Condensed, Ador Noirrit',
                                fontSize: 22,
                                color: Theme.of(context).highlightColor,
                              ),
                            ),
                            Text(
                              selectedLanguage == 1
                                  ? 'View all bills at a glance'
                                  : 'এক পলকে সকল আদেয়ক',
                              style: TextStyle(
                                  fontFamily: 'Roboto Condensed, Ador Noirrit',
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor),
                            ),
                          ],
                        ),
                      ),

                      Visibility(
                        visible: _isLoading,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorDark,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Shimmer.fromColors(
                                baseColor: Theme.of(context).primaryColorDark,
                                highlightColor:
                                    Theme.of(context).primaryColorLight,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColorDark,
                                    borderRadius: BorderRadius.circular(
                                      50,
                                    ),
                                  ),
                                  height: 10,
                                  width: double.infinity,
                                ),
                              ),
                              Shimmer.fromColors(
                                baseColor: Theme.of(context).primaryColorDark,
                                highlightColor:
                                    Theme.of(context).primaryColorLight,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColorDark,
                                    borderRadius: BorderRadius.circular(
                                      50,
                                    ),
                                  ),
                                  height: 8,
                                  width: double.infinity,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      //bill summary
                      Visibility(
                        visible: _isLoading == false,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorDark,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                //qty of payments bill
                                Column(
                                  children: [
                                    Text(
                                      selectedLanguage == 1
                                          ? 'Payments'
                                          : 'আদায়',
                                      style: TextStyle(
                                        color: Theme.of(context).highlightColor,
                                        fontFamily:
                                            'Roboto Condensed, Ador Noirrit',
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      '526',
                                      style: TextStyle(
                                        color: Theme.of(context).hintColor,
                                        fontFamily: 'Roboto Condensed',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),

                                //divider
                                SizedBox(
                                  height: 30,
                                  child: VerticalDivider(
                                    color: Theme.of(context).primaryColorLight,
                                    thickness: 0.2,
                                  ),
                                ),
                                //qty of unpayments bill
                                Column(
                                  children: [
                                    Text(
                                      selectedLanguage == 1 ? 'Bills' : 'রশিদ',
                                      style: TextStyle(
                                        color: Theme.of(context).highlightColor,
                                        fontFamily:
                                            'Roboto Condensed, Ador Noirrit',
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      '4',
                                      style: TextStyle(
                                        color: Theme.of(context).hintColor,
                                        fontFamily: 'Roboto Condensed',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),

                                //divider
                                SizedBox(
                                  height: 30,
                                  child: VerticalDivider(
                                    color: Theme.of(context).primaryColorLight,
                                    thickness: 0.2,
                                  ),
                                ),
                                //qty of cenceled bill
                                Column(
                                  children: [
                                    Text(
                                      selectedLanguage == 1
                                          ? 'Withdraws'
                                          : 'উত্তোলন',
                                      style: TextStyle(
                                        color: Theme.of(context).highlightColor,
                                        fontFamily:
                                            'Roboto Condensed, Ador Noirrit',
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      '25',
                                      style: TextStyle(
                                        color: Theme.of(context).hintColor,
                                        fontFamily: 'Roboto Condensed',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      // payments bills withdraws
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: FilterChip(
                              label: Text(
                                selectedLanguage == 1 ? 'Payments' : 'আদায়',
                                textAlign: TextAlign.center,
                              ),
                              showCheckmark: false,
                              backgroundColor:
                                  Theme.of(context).primaryColorDark,
                              selected: chips['payments'],
                              selectedColor: Theme.of(context).primaryColorDark,
                              elevation: 0,
                              pressElevation: 0,
                              side: BorderSide(
                                color: chips['payments']
                                    ? Theme.of(context).highlightColor
                                    : Theme.of(context).primaryColorDark,
                                width: 2,
                              ),
                              labelStyle: TextStyle(
                                fontFamily: 'Roboto Condensed, Ador Noirrit',
                                fontSize: 14,
                                color: Theme.of(context).highlightColor,
                              ),
                              checkmarkColor: Theme.of(context).highlightColor,
                              onSelected: (isSelected) {
                                setState(() {
                                  chips['payments'] = !chips['payments'];
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: FilterChip(
                              label: Text(
                                selectedLanguage == 1 ? 'Bills' : 'রশিদ',
                                textAlign: TextAlign.center,
                              ),
                              showCheckmark: false,
                              backgroundColor:
                                  Theme.of(context).primaryColorDark,
                              selected: chips['bills'],
                              selectedColor: Theme.of(context).primaryColorDark,
                              elevation: 0,
                              pressElevation: 0,
                              side: BorderSide(
                                color: chips['bills']
                                    ? Theme.of(context).highlightColor
                                    : Theme.of(context).primaryColor,
                                width: 2,
                              ),
                              labelStyle: TextStyle(
                                fontFamily: 'Roboto Condensed, Ador Noirrit',
                                fontSize: 14,
                                color: Theme.of(context).highlightColor,
                              ),
                              checkmarkColor: Theme.of(context).highlightColor,
                              onSelected: (isSelected) {
                                setState(() {
                                  chips['bills'] = !chips['bills'];
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: FilterChip(
                              label: Text(
                                selectedLanguage == 1
                                    ? 'Widthdraws'
                                    : 'উত্তোলন',
                                textAlign: TextAlign.center,
                              ),
                              showCheckmark: false,
                              backgroundColor:
                                  Theme.of(context).primaryColorDark,
                              selected: chips['withdraws'],
                              selectedColor: Theme.of(context).primaryColorDark,
                              elevation: 0,
                              pressElevation: 0,
                              side: BorderSide(
                                  color: chips['withdraws']
                                      ? Theme.of(context).highlightColor
                                      : Theme.of(context).primaryColorDark,
                                  width: 2,
                                  style: BorderStyle.solid),
                              labelStyle: TextStyle(
                                fontFamily: 'Roboto Condensed, Ador Noirrit',
                                fontSize: 14,
                                color: Theme.of(context).highlightColor,
                              ),
                              checkmarkColor: Theme.of(context).highlightColor,
                              onSelected: (isSelected) {
                                setState(() {
                                  chips['withdraws'] = !chips['withdraws'];
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      //divider
                      Divider(
                        color: Theme.of(context).highlightColor,
                        thickness: 0.1,
                      ),
                      //today tomorrow
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: GestureDetector(
                              onTap: _pickFromDate,
                              child: Chip(
                                label: Text(
                                  chips['from'],
                                  textAlign: TextAlign.center,
                                ),
                                backgroundColor:
                                    Theme.of(context).primaryColorDark,
                                elevation: 0,
                                side: BorderSide(
                                    color: Theme.of(context).highlightColor,
                                    width: 2,
                                    style: BorderStyle.solid),
                                labelStyle: TextStyle(
                                  fontFamily: 'Roboto Condensed, Ador Noirrit',
                                  fontSize: 14,
                                  color: Theme.of(context).highlightColor,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: GestureDetector(
                              onTap: _pickToDate,
                              child: Chip(
                                label: Text(
                                  chips['to'],
                                  textAlign: TextAlign.center,
                                ),
                                backgroundColor:
                                    Theme.of(context).primaryColorDark,
                                elevation: 0,
                                side: BorderSide(
                                    color: Theme.of(context).highlightColor,
                                    width: 2,
                                    style: BorderStyle.solid),
                                labelStyle: TextStyle(
                                  fontFamily: 'Roboto Condensed, Ador Noirrit',
                                  fontSize: 14,
                                  color: Theme.of(context).highlightColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //divider
                      Divider(
                        color: Theme.of(context).highlightColor,
                        thickness: 0.1,
                      ),
                      //asc apply
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: FilterChip(
                              label: Text(
                                selectedLanguage == 1 ? 'Ascending' : 'অধিরোহণ',
                                textAlign: TextAlign.center,
                              ),
                              showCheckmark: false,
                              backgroundColor:
                                  Theme.of(context).primaryColorDark,
                              selected: chips['asc'],
                              selectedColor: Theme.of(context).primaryColorDark,
                              elevation: 0,
                              pressElevation: 0,
                              side: BorderSide(
                                  color: chips['asc']
                                      ? Theme.of(context).highlightColor
                                      : Theme.of(context).primaryColorDark,
                                  width: 2,
                                  style: BorderStyle.solid),
                              labelStyle: TextStyle(
                                fontFamily: 'Roboto Condensed',
                                fontSize: 14,
                                color: Theme.of(context).highlightColor,
                              ),
                              checkmarkColor: Theme.of(context).highlightColor,
                              onSelected: (isSelected) {
                                setState(() {
                                  chips['asc'] = !chips['asc'];
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Theme.of(context).primaryColorDark,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              child: SizedBox(
                                width: 70,
                                child: Text(
                                  selectedLanguage == 1 ? 'Apply' : 'অন্বেষণ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily:
                                        'Roboto Condensed, Ador Noirrit',
                                    color: Theme.of(context).highlightColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: _isLoading,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Shimmer.fromColors(
                          baseColor: Theme.of(context).primaryColor,
                          highlightColor: Theme.of(context).primaryColorLight,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorDark,
                              borderRadius: BorderRadius.circular(
                                50,
                              ),
                            ),
                            height: 12,
                            width: double.infinity,
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: Theme.of(context).primaryColor,
                          highlightColor: Theme.of(context).primaryColorLight,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorDark,
                              borderRadius: BorderRadius.circular(
                                50,
                              ),
                            ),
                            height: 12,
                            width: MediaQuery.of(context).size.width * 0.7,
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: Theme.of(context).primaryColor,
                          highlightColor: Theme.of(context).primaryColorLight,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorDark,
                              borderRadius: BorderRadius.circular(
                                50,
                              ),
                            ),
                            height: 12,
                            width: double.infinity,
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: Theme.of(context).primaryColor,
                          highlightColor: Theme.of(context).primaryColorLight,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorDark,
                              borderRadius: BorderRadius.circular(
                                50,
                              ),
                            ),
                            height: 12,
                            width: MediaQuery.of(context).size.width * 0.7,
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: Theme.of(context).primaryColor,
                          highlightColor: Theme.of(context).primaryColorLight,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorDark,
                              borderRadius: BorderRadius.circular(
                                50,
                              ),
                            ),
                            height: 12,
                            width: double.infinity,
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: Theme.of(context).primaryColor,
                          highlightColor: Theme.of(context).primaryColorLight,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorDark,
                              borderRadius: BorderRadius.circular(
                                50,
                              ),
                            ),
                            height: 12,
                            width: MediaQuery.of(context).size.width * 0.7,
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: Theme.of(context).primaryColor,
                          highlightColor: Theme.of(context).primaryColorLight,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorDark,
                              borderRadius: BorderRadius.circular(
                                50,
                              ),
                            ),
                            height: 12,
                            width: double.infinity,
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: Theme.of(context).primaryColor,
                          highlightColor: Theme.of(context).primaryColorLight,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorDark,
                              borderRadius: BorderRadius.circular(
                                50,
                              ),
                            ),
                            height: 12,
                            width: MediaQuery.of(context).size.width * 0.7,
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: Theme.of(context).primaryColor,
                          highlightColor: Theme.of(context).primaryColorLight,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorDark,
                              borderRadius: BorderRadius.circular(
                                50,
                              ),
                            ),
                            height: 12,
                            width: double.infinity,
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: Theme.of(context).primaryColor,
                          highlightColor: Theme.of(context).primaryColorLight,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorDark,
                              borderRadius: BorderRadius.circular(
                                50,
                              ),
                            ),
                            height: 12,
                            width: MediaQuery.of(context).size.width * 0.7,
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: Theme.of(context).primaryColor,
                          highlightColor: Theme.of(context).primaryColorLight,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorDark,
                              borderRadius: BorderRadius.circular(
                                50,
                              ),
                            ),
                            height: 12,
                            width: double.infinity,
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: Theme.of(context).primaryColor,
                          highlightColor: Theme.of(context).primaryColorLight,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorDark,
                              borderRadius: BorderRadius.circular(
                                50,
                              ),
                            ),
                            height: 12,
                            width: MediaQuery.of(context).size.width * 0.7,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: transactionList.isEmpty ? false : true,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      //padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          for (var transaction in transactionList)
                            Wrap(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColorDark,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  margin: EdgeInsets.only(
                                      bottom: transaction ==
                                              transactionList[
                                                  transactionList.length - 1]
                                          ? 0
                                          : 2),
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.call_received_rounded,
                                        color: Theme.of(context).indicatorColor,
                                        size: 20,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            transaction['name'],
                                            style: TextStyle(
                                                fontFamily: 'Roboto Condensed',
                                                fontSize: 18,
                                                color: Theme.of(context)
                                                    .hintColor),
                                          ),
                                          Text(
                                            transaction['trx'],
                                            style: TextStyle(
                                                color:
                                                    Theme.of(context).hintColor,
                                                fontSize: 12,
                                                fontFamily: 'Roboto Condensed'),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            transaction['amount'],
                                            style: TextStyle(
                                                color:
                                                    Theme.of(context).hintColor,
                                                fontSize: 16,
                                                fontFamily: 'Roboto Condensed'),
                                          ),
                                          Text(
                                            transaction['status'],
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .indicatorColor,
                                                fontSize: 12,
                                                fontFamily: 'Roboto Condensed'),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  void _pickFromDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((value) {
      setState(() {
        if (value != null) {
          chips['from'] =
              '${value.day.toString()}-${value.month.toString()}-${value.year.toString()}';
        }
      });
    });
  }

  void _pickToDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((value) {
      setState(() {
        if (value != null) {
          chips['to'] =
              '${value.day.toString()}-${value.month.toString()}-${value.year.toString()}';
        }
      });
    });
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isLoading = true;
    });
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var url =
          'https://us-central1-amardokan-5e0da.cloudfunctions.net/app/today?token=$token';
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final body = response.body;
      final json = jsonDecode(body);
      if (json['error'] == 0) {
        box.put('token', json['token']);
        setState(() {
          _isLoading = false;
          historyCard['payments'] = json['payments'];
          historyCard['bills'] = json['bills'];
          historyCard['withdraws'] = json['withdraws'];
          transactionList = json['transactions'];
        });
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Pin(),
          ),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        ),
      );
    }
  }
}
