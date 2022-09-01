import 'dart:html';

import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
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
          color: const Color(0xFF434B96),
          height: 200,
          backgroundColor: const Color(0xFF050933),
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
                    color: const Color(0xFF181D5A),
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
                          children: const [
                            Text(
                              'Bill Basket',
                              style: TextStyle(
                                fontFamily: 'Roboto Condensed',
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'View all bills at a glance',
                              style: TextStyle(
                                fontFamily: 'Roboto Condensed',
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),

                      //bill summary
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0A1042),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              //qty of paid bill
                              Column(
                                children: const [
                                  Text(
                                    'Paid',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Roboto Condensed',
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    '526',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'Roboto Condensed',
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),

                              //divider
                              const SizedBox(
                                height: 30,
                                child: VerticalDivider(
                                  color: Colors.white,
                                  thickness: 0.2,
                                ),
                              ),
                              //qty of unpaid bill
                              Column(
                                children: const [
                                  Text(
                                    'Pending',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Roboto Condensed',
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    '4',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'Roboto Condensed',
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),

                              //divider
                              const SizedBox(
                                height: 30,
                                child: VerticalDivider(
                                  color: Colors.white,
                                  thickness: 0.2,
                                ),
                              ),
                              //qty of cenceled bill
                              Column(
                                children: const [
                                  Text(
                                    'Postponed',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Roboto Condensed',
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    '25',
                                    style: TextStyle(
                                      color: Colors.grey,
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
                      color: const Color(0xFF181D5A),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // paid pending postponed
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: FilterChip(
                                label: const SizedBox(
                                  width: 70,
                                  child: Text(
                                    'Paid',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                backgroundColor: const Color(0xFF0A1042),
                                selected: chips['paid'],
                                selectedColor: const Color(0xFF0A1042),
                                elevation: 0,
                                pressElevation: 0,
                                shape: StadiumBorder(
                                    side: BorderSide(
                                        color: chips['paid']
                                            ? Colors.white
                                            : Colors.transparent,
                                        width: 2,
                                        style: BorderStyle.solid)),
                                labelStyle: const TextStyle(
                                  fontFamily: 'Roboto Condensed',
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                                checkmarkColor: Colors.white,
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
                                label: const SizedBox(
                                  width: 70,
                                  child: Text(
                                    'Pending',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                backgroundColor: const Color(0xFF0A1042),
                                selected: chips['pending'],
                                selectedColor: const Color(0xFF0A1042),
                                elevation: 0,
                                pressElevation: 0,
                                shape: StadiumBorder(
                                    side: BorderSide(
                                        color: chips['pending']
                                            ? Colors.white
                                            : Colors.transparent,
                                        width: 2,
                                        style: BorderStyle.solid)),
                                labelStyle: const TextStyle(
                                  fontFamily: 'Roboto Condensed',
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                                checkmarkColor: Colors.white,
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
                                label: const SizedBox(
                                    width: 70,
                                    child: Text(
                                      'Postponed',
                                      textAlign: TextAlign.center,
                                    )),
                                backgroundColor: const Color(0xFF0A1042),
                                selected: chips['postponed'],
                                selectedColor: const Color(0xFF0A1042),
                                elevation: 0,
                                pressElevation: 0,
                                shape: StadiumBorder(
                                    side: BorderSide(
                                        color: chips['postponed']
                                            ? Colors.white
                                            : Colors.transparent,
                                        width: 2,
                                        style: BorderStyle.solid)),
                                labelStyle: const TextStyle(
                                  fontFamily: 'Roboto Condensed',
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                                checkmarkColor: Colors.white,
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
                        const SizedBox(
                          height: 114,
                          child: VerticalDivider(
                            color: Colors.white,
                            thickness: 0.2,
                          ),
                        ),
                        //today tomorrow
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: FilterChip(
                                label: const SizedBox(
                                    width: 70,
                                    child: Text(
                                      'July',
                                      textAlign: TextAlign.center,
                                    )),
                                backgroundColor: const Color(0xFF0A1042),
                                selected: chips['month'],
                                selectedColor: const Color(0xFF0A1042),
                                elevation: 0,
                                pressElevation: 0,
                                shape: StadiumBorder(
                                    side: BorderSide(
                                        color: chips['month']
                                            ? Colors.white
                                            : Colors.transparent,
                                        width: 2,
                                        style: BorderStyle.solid)),
                                labelStyle: const TextStyle(
                                  fontFamily: 'Roboto Condensed',
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                                checkmarkColor: Colors.white,
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
                                label: const SizedBox(
                                    width: 70,
                                    child: Text(
                                      'Last week',
                                      textAlign: TextAlign.center,
                                    )),
                                backgroundColor: const Color(0xFF0A1042),
                                selected: chips['week'],
                                selectedColor: const Color(0xFF0A1042),
                                elevation: 0,
                                pressElevation: 0,
                                shape: StadiumBorder(
                                    side: BorderSide(
                                        color: chips['week']
                                            ? Colors.white
                                            : Colors.transparent,
                                        width: 2,
                                        style: BorderStyle.solid)),
                                labelStyle: const TextStyle(
                                  fontFamily: 'Roboto Condensed',
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                                checkmarkColor: Colors.white,
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
                                label: const SizedBox(
                                    width: 70,
                                    child: Text(
                                      'Today',
                                      textAlign: TextAlign.center,
                                    )),
                                backgroundColor: const Color(0xFF0A1042),
                                selected: chips['today'],
                                selectedColor: const Color(0xFF0A1042),
                                elevation: 0,
                                pressElevation: 0,
                                shape: StadiumBorder(
                                    side: BorderSide(
                                        color: chips['today']
                                            ? Colors.white
                                            : Colors.transparent,
                                        width: 2,
                                        style: BorderStyle.solid)),
                                labelStyle: const TextStyle(
                                  fontFamily: 'Roboto Condensed',
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                                checkmarkColor: Colors.white,
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
                        const SizedBox(
                          height: 114,
                          child: VerticalDivider(
                            color: Colors.white,
                            thickness: 0.2,
                          ),
                        ),
                        //asc apply
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: FilterChip(
                                label: const SizedBox(
                                    width: 70,
                                    child: Text(
                                      'Asc',
                                      textAlign: TextAlign.center,
                                    )),
                                backgroundColor: const Color(0xFF0A1042),
                                selected: chips['asc'],
                                selectedColor: const Color(0xFF0A1042),
                                elevation: 0,
                                pressElevation: 0,
                                shape: StadiumBorder(
                                    side: BorderSide(
                                        color: chips['asc']
                                            ? Colors.white
                                            : Colors.transparent,
                                        width: 2,
                                        style: BorderStyle.solid)),
                                labelStyle: const TextStyle(
                                  fontFamily: 'Roboto Condensed',
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                                checkmarkColor: Colors.white,
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
                                  primary:
                                      const Color.fromARGB(255, 60, 68, 136),
                                  textStyle: const TextStyle(
                                    fontFamily: 'Roboto Condensed',
                                    color: Colors.white,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                child: const SizedBox(
                                    width: 70,
                                    child: Text(
                                      'Apply',
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
                Visibility(
                  visible: transactionList.isEmpty ? false : true,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                        color: const Color(0xFF181D5A),
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(136, 5, 9, 51),
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          for (var transaction in transactionList)
                            Wrap(
                              //padding: EdgeInsets.all(8),
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      Icons.call_received_rounded,
                                      color: Colors.lightGreenAccent,
                                      size: 20,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          transaction['name'],
                                          style: const TextStyle(
                                              fontFamily: 'Roboto Condensed',
                                              fontSize: 18,
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          transaction['trx'],
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                              fontFamily: 'Roboto Condensed'),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          transaction['amount'],
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                              fontFamily: 'Roboto Condensed'),
                                        ),
                                        Text(
                                          transaction['status'],
                                          style: const TextStyle(
                                              color: Colors.lightGreenAccent,
                                              fontSize: 12,
                                              fontFamily: 'Roboto Condensed'),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Visibility(
                                  visible: transaction ==
                                          transactionList[
                                              transactionList.length - 1]
                                      ? false
                                      : true,
                                  child: const Divider(
                                    color: Colors.white,
                                    thickness: 0.1,
                                  ),
                                )
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
