import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:hive/hive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:share_plus/share_plus.dart';
import './Splashscreen.dart';
import './pin.dart';
import './home.dart';

var box = Hive.box('agamiMerchant');

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var selectedLanguage = box.get('language', defaultValue: 1);
  List transactionList = [];
  List<double> weekdata = [0, 0, 0, 0, 0, 0, 0];
  List weekdates = [];
  var oneTimeBill = true;
  var billerid = '';
  var description = '';
  var amount = '';
  var isLoading = false;
  final token = box.get('token');
  var balance = '';
  var growth = '';
  var comparison = '';
  var today = '';
  var yesterday = '';
  var _creatingBill = false;
  String? avatar = FirebaseAuth.instance.currentUser!.photoURL;

  @override
  void initState() {
    _handleRefresh();
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
                        isLoading == true
                            ? Shimmer.fromColors(
                                baseColor: Theme.of(context).primaryColorDark,
                                highlightColor:
                                    Theme.of(context).primaryColorLight,
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
                                  height: 30,
                                  width: 60,
                                ),
                              )
                            : Text(
                                balance,
                                style: TextStyle(
                                    color: Theme.of(context).highlightColor,
                                    fontSize: 36,
                                    fontFamily: 'Roboto Condensed'),
                              ),
                      ],
                    ),
                    Column(
                      children: [
                        Visibility(
                          visible: comparison == '0',
                          child: Icon(
                            Icons.trending_up_rounded,
                            color: Theme.of(context).highlightColor,
                            size: 20,
                          ),
                        ),
                        Visibility(
                          visible: comparison == '1',
                          child: Icon(
                            Icons.trending_down_rounded,
                            color: Theme.of(context).highlightColor,
                            size: 20,
                          ),
                        ),
                        Visibility(
                          visible: comparison == '2',
                          child: Icon(
                            Icons.trending_flat_rounded,
                            color: Theme.of(context).highlightColor,
                            size: 20,
                          ),
                        ),
                        isLoading == true
                            ? Shimmer.fromColors(
                                baseColor: Theme.of(context).primaryColorDark,
                                highlightColor:
                                    Theme.of(context).primaryColorLight,
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
                                  width: 20,
                                ),
                              )
                            : Text(
                                '$growth%',
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
                            selectedLanguage == 1 ? 'Today' : 'আজ',
                            style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontFamily: 'Roboto Condensed, Ador Noirrit',
                                fontSize: 14),
                          ),
                          isLoading == true
                              ? Shimmer.fromColors(
                                  baseColor: Theme.of(context).primaryColorDark,
                                  highlightColor:
                                      Theme.of(context).primaryColorLight,
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
                                    height: 25,
                                    width: 60,
                                  ),
                                )
                              : Text(
                                  today,
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
                              child: GestureDetector(
                                onTap: _createBill,
                                child: Icon(
                                  Icons.add_rounded,
                                  color: Theme.of(context).highlightColor,
                                ),
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
                            selectedLanguage == 1 ? 'Yesterday' : 'গতকাল',
                            style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontFamily: 'Roboto Condensed',
                                fontSize: 14),
                          ),
                          isLoading == true
                              ? Shimmer.fromColors(
                                  baseColor: Theme.of(context).primaryColorDark,
                                  highlightColor:
                                      Theme.of(context).primaryColorLight,
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
                                    height: 25,
                                    width: 60,
                                  ),
                                )
                              : Text(
                                  yesterday,
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
                child: graphData(weekdata: weekdata, weekdates: weekdates),
              ),
              Visibility(
                visible: isLoading == true,
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                          height: 14,
                          width: MediaQuery.of(context).size.width * 0.65,
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
                          height: 14,
                          width: MediaQuery.of(context).size.width * 0.80,
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
                          height: 14,
                          width: MediaQuery.of(context).size.width * 0.65,
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
                          height: 14,
                          width: MediaQuery.of(context).size.width * 0.80,
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
                          height: 14,
                          width: MediaQuery.of(context).size.width * 0.65,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: transactionList.isEmpty && isLoading != true,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    height: 200,
                    child: Image.asset('assets/blank.png'),
                  ),
                ),
              ),
              Visibility(
                visible: transactionList.isNotEmpty && isLoading != true,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
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
                                          visible:
                                              transaction['type'] == 'Withdraw',
                                          child: Icon(
                                            Icons
                                                .account_balance_wallet_outlined,
                                            color: Theme.of(context)
                                                .indicatorColor,
                                            size: 20,
                                          ),
                                        ),
                                        Visibility(
                                          visible:
                                              transaction['type'] == 'Payment',
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          transaction['amount'],
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .indicatorColor,
                                              fontSize: 16,
                                              fontFamily: 'Roboto Condensed'),
                                        ),
                                        Text(
                                          transaction['type'],
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .highlightColor,
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
    setState(() {
      isLoading = true;
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
          today = json['weekdata'][0].toString();
          yesterday = json['weekdata'][1].toString();
          balance = json['balance'].toString();
          growth = json['growth'].toString();
          comparison = json['comparison'].toString();
          weekdata = List<double>.from(
              json['weekdata'].map((i) => i.toDouble()).toList());
          weekdates = json['days'];
          transactionList = json['transactions'];
          isLoading = false;
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

  void _createBill() {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Scaffold(
              backgroundColor: Theme.of(context).primaryColorDark,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 10,
                        bottom: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedLanguage == 1 ? 'Create bill' : 'বিল তৈরি',
                            style: TextStyle(
                              fontFamily: 'Roboto Condensed, Ador Noirrit',
                              fontSize: 22,
                              color: Theme.of(context).highlightColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            splashRadius: 25,
                            icon: Icon(
                              Icons.close_rounded,
                              color: Theme.of(context).highlightColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: FilterChip(
                                  label: Text(
                                    selectedLanguage == 1
                                        ? 'One Time Bill'
                                        : 'এককালীন বিল',
                                    textAlign: TextAlign.center,
                                  ),
                                  showCheckmark: false,
                                  backgroundColor:
                                      Theme.of(context).primaryColorDark,
                                  selected: oneTimeBill,
                                  selectedColor:
                                      Theme.of(context).primaryColorDark,
                                  elevation: 0,
                                  pressElevation: 0,
                                  side: BorderSide(
                                    color: oneTimeBill == true
                                        ? Theme.of(context).highlightColor
                                        : Theme.of(context).primaryColor,
                                    width: 0,
                                  ),
                                  labelStyle: TextStyle(
                                    fontFamily:
                                        'Roboto Condensed, Ador Noirrit',
                                    fontSize: 14,
                                    color: Theme.of(context).highlightColor,
                                  ),
                                  checkmarkColor:
                                      Theme.of(context).highlightColor,
                                  onSelected: (isSelected) {
                                    setState(() {
                                      oneTimeBill = !oneTimeBill;
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      oneTimeBill = false;
                                    });
                                  },
                                  child: Chip(
                                    label: Text(
                                      selectedLanguage == 1
                                          ? 'Regular bill'
                                          : 'নিয়মিত বিল',
                                      textAlign: TextAlign.center,
                                    ),
                                    backgroundColor:
                                        Theme.of(context).primaryColorDark,
                                    elevation: 0,
                                    side: BorderSide(
                                      color: oneTimeBill == false
                                          ? Theme.of(context).highlightColor
                                          : Theme.of(context).primaryColor,
                                      width: 0,
                                    ),
                                    labelStyle: TextStyle(
                                      fontFamily:
                                          'Roboto Condensed, Ador Noirrit',
                                      fontSize: 14,
                                      color: Theme.of(context).highlightColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: oneTimeBill == true,
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: TextField(
                                style: TextStyle(
                                  color: Theme.of(context).highlightColor,
                                  fontFamily: 'Roboto Condensed',
                                  fontSize: 18,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      width: 4,
                                      color: Theme.of(context).primaryColorDark,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      width: 4,
                                      color: Theme.of(context).primaryColorDark,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      width: 4,
                                      color: Theme.of(context).highlightColor,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  hintText: selectedLanguage == 1
                                      ? 'Biller ID or Phone (Optional)'
                                      : 'বিলদাতার আইডি বা ফোন (ঐচ্ছিক)',
                                  hintStyle: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontFamily:
                                        'Roboto Condensed, Ador Noirrit',
                                    fontSize: 18,
                                  ),
                                  counterText: "",
                                  labelText: selectedLanguage == 1
                                      ? "Biller ID or Phone"
                                      : "বিলদাতার আইডি বা ফোন",
                                  labelStyle: TextStyle(
                                      fontFamily:
                                          'Roboto Condensed, Ador Noirrit',
                                      color: Theme.of(context).highlightColor),
                                ),
                                cursorColor: Theme.of(context).highlightColor,
                                maxLength: 15,
                                keyboardType: TextInputType.number,
                                autocorrect: false,
                                onChanged: (value) {
                                  setState(() {
                                    billerid = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: TextField(
                              style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontFamily: 'Roboto Condensed',
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 4,
                                    color: Theme.of(context).primaryColorDark,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 4,
                                    color: Theme.of(context).primaryColorDark,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 4,
                                    color: Theme.of(context).highlightColor,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                hintText:
                                    selectedLanguage == 1 ? 'Amount' : 'পরিমাণ',
                                hintStyle: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  fontFamily: 'Roboto Condensed, Ador Noirrit',
                                  fontSize: 18,
                                ),
                                counterText: "",
                                labelText:
                                    selectedLanguage == 1 ? 'Amount' : 'পরিমাণ',
                                labelStyle: TextStyle(
                                    fontFamily:
                                        'Roboto Condensed, Ador Noirrit',
                                    color: Theme.of(context).highlightColor),
                              ),
                              cursorColor: Theme.of(context).highlightColor,
                              maxLength: 6,
                              keyboardType: TextInputType.number,
                              autocorrect: false,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r"^([0-9]{0,6})(\.\d{0,2})?"),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  amount = value;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: TextField(
                              style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontFamily: 'Roboto Condensed',
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 4,
                                    color: Theme.of(context).primaryColorDark,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 4,
                                    color: Theme.of(context).primaryColorDark,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 4,
                                    color: Theme.of(context).highlightColor,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                hintText: selectedLanguage == 1
                                    ? 'Discription'
                                    : 'বিবরণ',
                                hintStyle: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  fontFamily: 'Roboto Condensed, Ador Noirrit',
                                  fontSize: 18,
                                ),
                                labelText: selectedLanguage == 1
                                    ? "Discription"
                                    : "বিবরণ",
                                labelStyle: TextStyle(
                                  fontFamily: 'Roboto Condensed, Ador Noirrit',
                                  color: Theme.of(context).highlightColor,
                                ),
                                counterText: "",
                              ),
                              cursorColor: Theme.of(context).highlightColor,
                              maxLength: 90,
                              onChanged: (value) {
                                setState(() {
                                  description = value;
                                });
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: ElevatedButton(
                              onPressed: _addNewBill,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).primaryColorLight,
                                elevation: 0,
                                padding: EdgeInsets.all(20),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(8), // <-- Radius
                                ),
                              ),
                              child: Text(
                                selectedLanguage == 1
                                    ? 'Create Bill'
                                    : 'বিল তৈরি করুন',
                                style: TextStyle(
                                  color: Theme.of(context).highlightColor,
                                  fontSize: 18,
                                  fontFamily: 'Roboto Condensed, Ador Noirrit',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  void _addNewBill() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && amount.length >= 1 && description.length >= 1) {
      var url =
          'https://us-central1-amardokan-5e0da.cloudfunctions.net/app/addnewbill?token=$token&billerid=$billerid&amount=$amount&description=$description&onetimebill=$oneTimeBill';
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final body = response.body;
      final json = jsonDecode(body);
      if (json['error'] == 0) {
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
                                  ? 'Bill Status'
                                  : 'বিল অবস্থা',
                              style: TextStyle(
                                fontFamily: 'Roboto Condensed, Ador Noirrit',
                                color: Theme.of(context).highlightColor,
                                fontSize: 22,
                              ),
                            ),
                            Text(
                              selectedLanguage == 1
                                  ? 'Bill Created Successfully'
                                  : 'বিল সফলভাবে তৈরি হয়েছে',
                              style: TextStyle(
                                fontFamily: 'Roboto Condensed, Ador Noirrit',
                                color: Theme.of(context).highlightColor,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QrImage(
                        data: json['link'],
                        version: QrVersions.auto,
                        size: 200.0,
                        padding: EdgeInsets.all(20),
                        foregroundColor: Theme.of(context).highlightColor,
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
                            for (var item in json['info'])
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
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: json['link']));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 15),
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
                              json['link'],
                              style: TextStyle(
                                fontFamily: 'Roboto Condensed',
                                fontSize: 14,
                                color: Theme.of(context).highlightColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _onShare(context, json['link']);
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
                                  fontFamily: 'Roboto Condensed, Ador Noirrit',
                                  color: Theme.of(context).highlightColor,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Home(),
                                ),
                              );
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
          },
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Pin(),
          ),
        );
      }
    } else if (amount.length == 0 || description.length == 0) {
      showDialog(
        context: context,
        builder: (context) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Scaffold(
              backgroundColor: Color.fromARGB(183, 0, 0, 0),
              body: Center(
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(25),
                  constraints: BoxConstraints(maxWidth: 350),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    selectedLanguage == 1
                        ? 'Amount and description of bill can not be null'
                        : 'বিলের পরিমাণ ও বর্ণনা পূরণ আবশ্যক',
                    style: TextStyle(
                      fontFamily: 'Roboto Condensed, Ador Noirrit',
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Theme.of(context).highlightColor,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        ),
      );
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
}

class graphData extends StatefulWidget {
  graphData({Key? key, required this.weekdata, required this.weekdates})
      : super(key: key);

  List<double> weekdata;
  List weekdates;

  @override
  State<graphData> createState() => _graphDataState();
}

class _graphDataState extends State<graphData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Sparkline(
          data: widget.weekdata,
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
            children: [
              for (var date in widget.weekdates)
                Text(
                  date.toString(),
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
