//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:hive/hive.dart';

var box = Hive.box('agamiMerchant');

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  var selectedLanguage = box.get('language', defaultValue: 1);
  Map chips = {
    "paid": true,
    "pending": true,
    "postponed": true,
    "today": false,
    "week": true,
    "month": false,
    "asc": false,
  };
  List transactionList = [
    {
      "name": "A. Basir",
      "status": "Withdraw",
      "amount": "25000",
      "trx": "D5G46G84W6W5"
    },
    {
      "name": "A. Basir",
      "status": "Withdraw",
      "amount": "25000",
      "trx": "D5G46G84W6W5"
    },
    {
      "name": "A. Basir",
      "status": "Withdraw",
      "amount": "25000",
      "trx": "D5G46G84W6W5"
    },
    {
      "name": "A. Basir",
      "status": "Withdraw",
      "amount": "25000",
      "trx": "D5G46G84W6W5"
    },
    {
      "name": "A. Basir",
      "status": "Withdraw",
      "amount": "25000",
      "trx": "D5G46G84W6W5"
    },
    {
      "name": "A. Basir",
      "status": "Withdraw",
      "amount": "25000",
      "trx": "D5G46G84W6W5"
    },
    {
      "name": "A. Basir",
      "status": "Withdraw",
      "amount": "25000",
      "trx": "D5G46G84W6W5"
    },
    {
      "name": "A. Basir",
      "status": "Withdraw",
      "amount": "25000",
      "trx": "D5G46G84W6W5"
    },
  ];

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

                      //bill summary
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorDark,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              //qty of paid bill
                              Column(
                                children: [
                                  Text(
                                    selectedLanguage == 1 ? 'Paid' : 'পরিশোধিত',
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
                              //qty of unpaid bill
                              Column(
                                children: [
                                  Text(
                                    selectedLanguage == 1
                                        ? 'Pending'
                                        : 'প্রক্রিয়াধীন',
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
                                        ? 'Postponed'
                                        : 'বাতিলকৃত',
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
                      // paid pending postponed
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: FilterChip(
                              label: Text(
                                selectedLanguage == 1 ? 'Paid' : 'পরিশোধিত',
                                textAlign: TextAlign.center,
                              ),
                              showCheckmark: false,
                              backgroundColor:
                                  Theme.of(context).primaryColorDark,
                              selected: chips['paid'],
                              selectedColor: Theme.of(context).primaryColorDark,
                              elevation: 0,
                              pressElevation: 0,
                              side: BorderSide(
                                color: chips['paid']
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
                                  chips['paid'] = !chips['paid'];
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: FilterChip(
                              label: Text(
                                selectedLanguage == 1
                                    ? 'Pending'
                                    : 'প্রক্রিয়াধীন',
                                textAlign: TextAlign.center,
                              ),
                              showCheckmark: false,
                              backgroundColor:
                                  Theme.of(context).primaryColorDark,
                              selected: chips['pending'],
                              selectedColor: Theme.of(context).primaryColorDark,
                              elevation: 0,
                              pressElevation: 0,
                              side: BorderSide(
                                color: chips['pending']
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
                                  chips['pending'] = !chips['pending'];
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: FilterChip(
                              label: Text(
                                selectedLanguage == 1
                                    ? 'Postponed'
                                    : 'বাতিলকৃত',
                                textAlign: TextAlign.center,
                              ),
                              showCheckmark: false,
                              backgroundColor:
                                  Theme.of(context).primaryColorDark,
                              selected: chips['postponed'],
                              selectedColor: Theme.of(context).primaryColorDark,
                              elevation: 0,
                              pressElevation: 0,
                              side: BorderSide(
                                  color: chips['postponed']
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
                                  chips['postponed'] = !chips['postponed'];
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
                            child: FilterChip(
                              label: const Text(
                                'July',
                                textAlign: TextAlign.center,
                              ),
                              showCheckmark: false,
                              backgroundColor:
                                  Theme.of(context).primaryColorDark,
                              selected: chips['month'],
                              selectedColor: Theme.of(context).primaryColorDark,
                              elevation: 0,
                              pressElevation: 0,
                              side: BorderSide(
                                  color: chips['month']
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
                                  chips['today'] = false;
                                  chips['week'] = false;
                                  chips['month'] = true;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: FilterChip(
                              label: Text(
                                selectedLanguage == 1
                                    ? 'Last week'
                                    : 'বিগত সপ্তাহ',
                                textAlign: TextAlign.center,
                              ),
                              showCheckmark: false,
                              backgroundColor:
                                  Theme.of(context).primaryColorDark,
                              selected: chips['week'],
                              selectedColor: Theme.of(context).primaryColorDark,
                              elevation: 0,
                              pressElevation: 0,
                              side: BorderSide(
                                  color: chips['week']
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
                                  chips['today'] = false;
                                  chips['week'] = true;
                                  chips['month'] = false;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: FilterChip(
                              label: Text(
                                selectedLanguage == 1 ? 'Today' : 'আজ',
                                textAlign: TextAlign.center,
                              ),
                              showCheckmark: false,
                              backgroundColor:
                                  Theme.of(context).primaryColorDark,
                              selected: chips['today'],
                              selectedColor: Theme.of(context).primaryColorDark,
                              elevation: 0,
                              pressElevation: 0,
                              side: BorderSide(
                                  color: chips['today']
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
                                  chips['today'] = true;
                                  chips['week'] = false;
                                  chips['month'] = false;
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

  Future<void> _handleRefresh() async {
    return await Future.delayed(const Duration(seconds: 1));
  }
}
