import 'dart:convert';
import 'package:agami/home.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:hive/hive.dart';
import 'package:shimmer/shimmer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';
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
  String datefrom = "";
  String dateto = "";
  Map historyCard = {
    "payments": '0',
    "bills": '0',
    "withdraws": '0',
  };
  List transactionList = [];

  @override
  void initState() {
    _handleRefresh();
    chips['from'] =
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';
    datefrom =
        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day} 12:59:59 PM';
    chips['to'] =
        '${DateTime.now().subtract(const Duration(days: 30)).day}-${DateTime.now().subtract(const Duration(days: 30)).month}-${DateTime.now().subtract(const Duration(days: 30)).year}';
    dateto =
        '${DateTime.now().subtract(const Duration(days: 30)).year}-${DateTime.now().subtract(const Duration(days: 30)).month}-${DateTime.now().subtract(const Duration(days: 30)).day} 12:00:00 AM';
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
                                  : 'বিল ঝুড়ি',
                              style: TextStyle(
                                fontFamily: 'Roboto Condensed, Ador Noirrit',
                                fontSize: 22,
                                color: Theme.of(context).highlightColor,
                              ),
                            ),
                            Text(
                              selectedLanguage == 1
                                  ? 'View all bill at a glance'
                                  : 'এক নজরে সকল বিল',
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
                                      historyCard['payments'],
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
                                      selectedLanguage == 1
                                          ? 'Bills'
                                          : 'বিলসমূহ',
                                      style: TextStyle(
                                        color: Theme.of(context).highlightColor,
                                        fontFamily:
                                            'Roboto Condensed, Ador Noirrit',
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      historyCard['bills'],
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
                                      historyCard['withdraws'],
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    selectedLanguage == 1
                        ? 'Filter your transactions'
                        : 'আপনার লেনদেন ফিল্টার করুন',
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontFamily: 'Roboto Condensed, Ador Noirrit',
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                    ),
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
                                selectedLanguage == 1 ? 'Bills' : 'বিলসমূহ',
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
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              selectedLanguage == 1 ? 'to' : 'থেকে',
                              style: TextStyle(
                                  color: Theme.of(context).highlightColor,
                                  fontSize: 14,
                                  fontFamily: 'Roboto Condensed, Ador Noirrit'),
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
                                selectedLanguage == 1
                                    ? 'Ascending'
                                    : 'উর্ধ্বক্রমানুসারে',
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
                              onPressed: _searchHistory,
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
                                  selectedLanguage == 1 ? 'Search' : 'খুঁজুন',
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
                                GestureDetector(
                                  onTap: () {
                                    _trxDetails(transaction);
                                  },
                                  child: Container(
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
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Visibility(
                                              visible:
                                                  transaction['type'] == 'Bill',
                                              child: Icon(
                                                Icons.sell_outlined,
                                                color: Theme.of(context)
                                                    .indicatorColor,
                                                size: 20,
                                              ),
                                            ),
                                            Visibility(
                                              visible: transaction['type'] ==
                                                  'Withdraw',
                                              child: Icon(
                                                Icons
                                                    .account_balance_wallet_outlined,
                                                color: Theme.of(context)
                                                    .indicatorColor,
                                                size: 20,
                                              ),
                                            ),
                                            Visibility(
                                              visible: transaction['type'] ==
                                                  'Payment',
                                              child: Icon(
                                                Icons.credit_score_rounded,
                                                color: Theme.of(context)
                                                    .indicatorColor,
                                                size: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              transaction['date'],
                                              style: TextStyle(
                                                  fontFamily:
                                                      'Roboto Condensed',
                                                  fontSize: 18,
                                                  color: Theme.of(context)
                                                      .hintColor),
                                            ),
                                            Text(
                                              transaction['trx'],
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .hintColor,
                                                  fontSize: 12,
                                                  fontFamily:
                                                      'Roboto Condensed'),
                                            )
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              transaction['amount'],
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .indicatorColor,
                                                  fontSize: 16,
                                                  fontFamily:
                                                      'Roboto Condensed'),
                                            ),
                                            Text(
                                              transaction['type'],
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .highlightColor,
                                                  fontSize: 12,
                                                  fontFamily:
                                                      'Roboto Condensed'),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
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
          datefrom =
              '${value.year.toString()}-${value.month.toString()}-${value.day.toString()} 12:59:59 PM';
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
          dateto =
              '${value.year.toString()}-${value.month.toString()}-${value.day.toString()} 12:00:00 AM';
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
      var df =
          '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day} 12:59:59 PM';

      var dt =
          '${DateTime.now().subtract(const Duration(days: 30)).year}-${DateTime.now().subtract(const Duration(days: 30)).month}-${DateTime.now().subtract(const Duration(days: 30)).day} 12:00:00 AM';
      var url =
          "https://us-central1-amardokan-5e0da.cloudfunctions.net/app/history?token=$token&datefrom=$df&dateto=$dt&order=desc";
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final body = response.body;
      final json = jsonDecode(body);
      if (json['error'] == 0) {
        box.put('token', json['token']);
        setState(() {
          _isLoading = false;
          historyCard['payments'] = json['payment'];
          historyCard['bills'] = json['bill'];
          historyCard['withdraws'] = json['withdraw'];
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

  void _searchHistory() async {
    setState(() {
      _isLoading = true;
    });
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var restparams = '';
      if (chips['payments'] == true) {
        restparams = restparams + '&payment=true';
      }
      if (chips['withdraws'] == true) {
        restparams = restparams + '&withdraw=true';
      }
      if (chips['bills'] == true) {
        restparams = restparams + '&bill=true';
      }
      if (chips['asc'] == true) {
        restparams = restparams + '&order=asc';
      }
      var url =
          "https://us-central1-amardokan-5e0da.cloudfunctions.net/app/history?token=$token&datefrom=$datefrom&dateto=$dateto$restparams";
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final body = response.body;
      final json = jsonDecode(body);
      if (json['error'] == 0) {
        box.put('token', json['token']);
        setState(() {
          _isLoading = false;
          historyCard['payments'] = json['payment'];
          historyCard['bills'] = json['bill'];
          historyCard['withdraws'] = json['withdraw'];
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

  void _trxDetails(transaction) {
    showDialog(
        context: context,
        builder: (context) {
          return Scaffold(
            backgroundColor: Theme.of(context).primaryColorDark,
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorDark,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(15),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Text(
                            selectedLanguage == 1
                                ? 'Transaction Status'
                                : 'ট্রানজেকশন অবস্থা',
                            style: TextStyle(
                              fontFamily: 'Roboto Condensed, Ador Noirrit',
                              color: Theme.of(context).highlightColor,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                    transaction['type'] == 'Bill'
                        ? QrImage(
                            data: transaction['link'],
                            version: QrVersions.auto,
                            size: 200.0,
                            padding: EdgeInsets.all(20),
                            foregroundColor: Theme.of(context).highlightColor,
                          )
                        : SizedBox(
                            width: 100,
                            height: 10,
                          ),
                    Container(
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorDark,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          for (var item in transaction['info'])
                            Text(
                              item.keys.toList().first +
                                  ' : ' +
                                  item.values.toList().first,
                              style: TextStyle(
                                fontFamily: 'Roboto Condensed',
                                fontSize: 16,
                                color: Theme.of(context).highlightColor,
                              ),
                            )
                        ],
                      ),
                    ),
                    transaction['type'] == 'Bill'
                        ? GestureDetector(
                            onTap: () {
                              Clipboard.setData(
                                  ClipboardData(text: transaction['link']));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 15),
                              child: Chip(
                                backgroundColor:
                                    Theme.of(context).primaryColorLight,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                label: Text(
                                  transaction['link'],
                                  style: TextStyle(
                                    fontFamily: 'Roboto Condensed',
                                    fontSize: 14,
                                    color: Theme.of(context).highlightColor,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(
                            width: 10,
                            height: 5,
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: transaction['type'] == 'Withdraw' &&
                              transaction['status'] == 'pending',
                          child: GestureDetector(
                            onTap: () {
                              declineWithdraw(transaction['trx']);
                            },
                            child: Container(
                              margin: EdgeInsets.all(5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColorDark,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              width: 100,
                              height: 30,
                              child: Text(
                                selectedLanguage == 1 ? "Decline" : "বাতিল",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Roboto Condensed, Ador Noirrit',
                                  color: Theme.of(context).highlightColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: transaction['type'] == 'Bill' &&
                              transaction['status'] == 'active',
                          child: GestureDetector(
                            onTap: () {
                              declineBill(transaction['trx']);
                            },
                            child: Container(
                              margin: EdgeInsets.all(5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColorDark,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              width: 100,
                              height: 30,
                              child: Text(
                                selectedLanguage == 1 ? "Decline" : "বাতিল",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Roboto Condensed, Ador Noirrit',
                                  color: Theme.of(context).highlightColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        transaction['type'] == 'Bill'
                            ? GestureDetector(
                                onTap: () {
                                  _onShare(context, transaction['link']);
                                },
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColorDark,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  width: 100,
                                  height: 30,
                                  child: Text(
                                    selectedLanguage == 1 ? "Share" : "শেয়ার",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily:
                                          'Roboto Condensed, Ador Noirrit',
                                      color: Theme.of(context).highlightColor,
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                (MaterialPageRoute(
                                    builder: (context) => Home())));
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorDark,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            width: 100,
                            height: 30,
                            child: Text(
                              selectedLanguage == 1
                                  ? "Dashboard"
                                  : "ড্যাশবোর্ড",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Roboto Condensed, Ador Noirrit',
                                color: Theme.of(context).highlightColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void declineWithdraw(trx) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var url =
          'https://us-central1-amardokan-5e0da.cloudfunctions.net/app/declinewithdraw?token=$token&trx=$trx';
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final body = response.body;
      final json = jsonDecode(body);
      if (json['error'] == 0) {
        box.put('token', json['token']);
        Navigator.push(
            context, (MaterialPageRoute(builder: (context) => Home())));
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

  void declineBill(trx) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var url =
          'https://us-central1-amardokan-5e0da.cloudfunctions.net/app/declinebill?token=$token&trx=$trx';
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final body = response.body;
      final json = jsonDecode(body);
      if (json['error'] == 0) {
        box.put('token', json['token']);
        Navigator.push(
            context, (MaterialPageRoute(builder: (context) => Home())));
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

void _onShare(BuildContext context, String text) async {
  final box = context.findRenderObject() as RenderBox?;

  await Share.share(
    text,
    subject: "",
    sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
  );
}
