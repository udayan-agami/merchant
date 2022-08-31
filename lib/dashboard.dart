import 'dart:ui';

import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List transactionList = [
    {
      'name': 'M. Akbar',
      'trx': '65EG61G6W1G6W',
      'amount': '1452',
      'type': 'r',
      'status': 'paid'
    },
    {
      'name': 'H. Ar Rasid',
      'trx': '65EG61G6W1G6W',
      'amount': '1452',
      'type': 'r',
      'status': 'paid'
    },
    {
      'name': 'M. Akbar',
      'trx': '65EG61G6W1G6W',
      'amount': '1452',
      'type': 'r',
      'status': 'paid'
    },
    {
      'name': 'H. Ar Rasid',
      'trx': '65EG61G6W1G6W',
      'amount': '1452',
      'type': 'r',
      'status': 'paid'
    },
    {
      'name': 'M. Akbar',
      'trx': '65EG61G6W1G6W',
      'amount': '1452',
      'type': 'r',
      'status': 'paid'
    },
    {
      'name': 'H. Ar Rasid',
      'trx': '65EG61G6W1G6W',
      'amount': '1452',
      'type': 'r',
      'status': 'paid'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF050933),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF434B96),
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: const SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: GNav(
                padding: EdgeInsets.all(5),
                tabBorderRadius: 100,
                iconSize: 28,
                gap: 8,
                tabBackgroundColor: Color.fromARGB(87, 5, 9, 51),
                textStyle: TextStyle(
                    fontFamily: 'Roboto Condensed', color: Colors.white),
                tabs: [
                  GButton(
                      icon: Icons.featured_play_list_outlined,
                      text: 'History',
                      iconColor: Colors.blueGrey,
                      iconActiveColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                  GButton(
                      icon: Icons.space_dashboard_outlined,
                      text: 'Dashboard',
                      iconColor: Colors.blueGrey,
                      iconActiveColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                  GButton(
                      icon: Icons.admin_panel_settings_outlined,
                      text: 'Settings',
                      iconColor: Colors.blueGrey,
                      iconActiveColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20))
                ]),
          )),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: const Color(0xFF050933),
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CircleAvatar(
                      backgroundImage:
                          NetworkImage('https://i.ibb.co/stQv06t/unnamed.jpg'),
                      backgroundColor: Color(0xFF181D5A),
                    ),
                    Container(
                      alignment: Alignment.center,
                      color: const Color(0xFF050933),
                      child: const Text(
                        'Dashboard',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontFamily: 'Roboto Condensed'),
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
              Container(
                margin: const EdgeInsets.all(10),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 28),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFF181D5A),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(' '),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Icon(
                            MdiIcons.currencyBdt,
                            color: Colors.white,
                            size: 16,
                          ),
                          Text('5672.25',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontFamily: 'Roboto Condensed'))
                        ],
                      ),
                      Column(
                        children: const [
                          Icon(
                            Icons.trending_up_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                          Text(
                            '10%',
                            style: TextStyle(
                                fontFamily: 'Roboto Condensed',
                                fontSize: 14,
                                color: Colors.white),
                          )
                        ],
                      )
                    ]),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFF181D5A),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          children: const [
                            Text(
                              'Pending',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto Condensed',
                                  fontSize: 14),
                            ),
                            Text(
                              '4',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto Condensed',
                                  fontSize: 28),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            color: const Color(0xFF050933),
                            width: 10,
                            height: 76,
                          ),
                          Container(
                            height: 56,
                            width: 56,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              color: const Color(0xFF050933),
                            ),
                            child: Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(23),
                                color: const Color(0xFF181D5A),
                              ),
                              child: const Icon(
                                Icons.add_rounded,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      )),
                      Expanded(
                        child: Column(
                          children: const [
                            Text(
                              'Paid',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto Condensed',
                                  fontSize: 14),
                            ),
                            Text(
                              '41',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto Condensed',
                                  fontSize: 28),
                            ),
                          ],
                        ),
                      )
                    ]),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                decoration: BoxDecoration(
                    color: const Color(0xFF181D5A),
                    borderRadius: BorderRadius.circular(15)),
                child: const graphData(),
              ),
              Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: const Color(0xFF181D5A),
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(136, 5, 9, 51),
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          for (var transaction in transactionList)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      style: TextStyle(
                                          fontFamily: 'Roboto Condensed',
                                          fontSize: 18,
                                          color: Colors.grey),
                                    ),
                                    Text(
                                      transaction['trx'],
                                      style: TextStyle(
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
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontFamily: 'Roboto Condensed'),
                                    ),
                                    Text(
                                      transaction['status'],
                                      style: TextStyle(
                                          color: Colors.lightGreenAccent,
                                          fontSize: 12,
                                          fontFamily: 'Roboto Condensed'),
                                    )
                                  ],
                                )
                              ],
                            ),
                        ],
                      )))
            ],
          ),
        )));
  }
}

class graphData extends StatefulWidget {
  const graphData({Key? key}) : super(key: key);

  @override
  State<graphData> createState() => _graphDataState();
}

class _graphDataState extends State<graphData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Sparkline(
          data: [2300, 5000, 2000, 200, 301, 0, 750],
          // backgroundColor: Colors.red,
          // lineColor: Colors.lightGreen[500]!,
          // fillMode: FillMode.below,
          // fillColor: Colors.lightGreen[200]!,
          // pointsMode: PointsMode.all,
          // pointSize: 5.0,
          // pointColor: Colors.amber,
          useCubicSmoothing: true,
          lineWidth: 4.0,
          cubicSmoothingFactor: 0.1,
          // gridLinelabelPrefix: '\$',
          // gridLineLabelPrecision: 3,
          // enableGridLines: true,
          // averageLine: true,
          // averageLabel: true,
          // kLine: ['max', 'min', 'first', 'last'],
          // // max: 50.5,
          // // min: 10.0,
          // enableThreshold: true,
          // thresholdSize: 0.1,
          lineGradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFFD66B5F), Color(0xFFE1D044)],
          ),
          // fillGradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [Colors.red[800]!, Colors.red[200]!],
          // ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                '23',
                style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Roboto Condensed',
                    fontSize: 12),
              ),
              Text(
                '24',
                style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Roboto Condensed',
                    fontSize: 12),
              ),
              Text(
                '25',
                style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Roboto Condensed',
                    fontSize: 12),
              ),
              Text(
                '26',
                style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Roboto Condensed',
                    fontSize: 12),
              ),
              Text(
                '27',
                style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Roboto Condensed',
                    fontSize: 12),
              ),
              Text(
                '28',
                style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Roboto Condensed',
                    fontSize: 12),
              ),
              Text(
                '29',
                style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Roboto Condensed',
                    fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
