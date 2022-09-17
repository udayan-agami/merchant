import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:hive/hive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

var box = Hive.box('agamiMerchant');

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var selectedLanguage = box.get('language', defaultValue: 1);
  final List transactionList = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? avatar = FirebaseAuth.instance.currentUser!.photoURL;
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
                color: Theme.of(context).primaryColorDark,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          const AssetImage('assets/default-photo.png'),
                      foregroundImage: NetworkImage('$avatar'),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    Container(
                      alignment: Alignment.center,
                      color: Theme.of(context).primaryColorDark,
                      child: Text(
                        selectedLanguage == 1 ? 'Dashboard' : 'ড্যাশবোর্ড',
                        style: TextStyle(
                            color: Theme.of(context).highlightColor,
                            fontSize: 22,
                            fontFamily: 'Roboto Condensed, Ador Noirrit'),
                      ),
                    ),
                    IconButton(
                      splashRadius: 10,
                      onPressed: () {
                        if (box.get('theme') == 1 || box.get('theme') == 2) {
                          box.put('theme', 3);
                        } else {
                          box.put('theme', 1);
                        }
                      },
                      icon: const Icon(Icons.lightbulb_outline_rounded),
                      color: Theme.of(context).highlightColor,
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
                  color: Theme.of(context).primaryColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(' '),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          MdiIcons.currencyBdt,
                          color: Theme.of(context).highlightColor,
                          size: 16,
                        ),
                        Text(
                          '5672.25',
                          style: TextStyle(
                              color: Theme.of(context).highlightColor,
                              fontSize: 36,
                              fontFamily: 'Roboto Condensed'),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.trending_up_rounded,
                          color: Theme.of(context).highlightColor,
                          size: 20,
                        ),
                        Text(
                          '10%',
                          style: TextStyle(
                              fontFamily: 'Roboto Condensed',
                              fontSize: 14,
                              color: Theme.of(context).highlightColor),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).primaryColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            selectedLanguage == 1 ? 'Pending' : 'প্রক্রিয়াধীন',
                            style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontFamily: 'Roboto Condensed, Ador Noirrit',
                                fontSize: 14),
                          ),
                          Text(
                            '4',
                            style: TextStyle(
                                color: Theme.of(context).highlightColor,
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
                            color: Theme.of(context).primaryColorDark,
                            width: 10,
                            height: 76,
                          ),
                          Container(
                            height: 56,
                            width: 56,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              color: Theme.of(context).primaryColorDark,
                            ),
                            child: Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(23),
                                color: Theme.of(context).primaryColor,
                              ),
                              child: Icon(
                                Icons.add_rounded,
                                color: Theme.of(context).highlightColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            selectedLanguage == 1 ? 'Paid' : 'পরিশোধিত',
                            style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontFamily: 'Roboto Condensed',
                                fontSize: 14),
                          ),
                          Text(
                            '41',
                            style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontFamily: 'Roboto Condensed',
                                fontSize: 28),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15)),
                child: const graphData(),
              ),
              Visibility(
                visible: transactionList.isEmpty ? true : false,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    height: 200,
                    child: Image.asset('assets/blank.png'),
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
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12)),
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
                                              color:
                                                  Theme.of(context).hintColor),
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
        ),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    return await Future.delayed(const Duration(seconds: 1));
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
          padding: const EdgeInsets.symmetric(vertical: 10),
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
                  fontSize: 12,
                ),
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
