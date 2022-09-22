import 'dart:convert';
import './business.dart';
import './pin.dart';
import './Splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shimmer/shimmer.dart';

var box = Hive.box('agamiMerchant');

class Withdraw extends StatefulWidget {
  const Withdraw({Key? key}) : super(key: key);

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  //variables
  final token = box.get('token', defaultValue: 'null');
  var selectedLanguage = box.get('language', defaultValue: 1);
  var balance = 0;
  List withdrawMethos = [];
  String? _amountToWithdraw;
  Map withdrawCredential = {};
  var _selectedMethod;
  var _isDocumentVerified;
  var _isLoading = false;
  @override
  void initState() {
    _handleRefresh();
    super.initState();
  }

  //methods
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: SafeArea(
        child: SingleChildScrollView(
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
                      selectedLanguage == 1 ? 'Withdraw' : 'উত্তোলন',
                      style: TextStyle(
                        color: Theme.of(context).highlightColor,
                        fontFamily: 'Roboto Condensed, Ador Noirrit',
                        fontSize: 22,
                      ),
                    ),
                    IconButton(
                      onPressed: _handleRefresh,
                      icon: Icon(
                        Icons.refresh_rounded,
                        color: Theme.of(context).highlightColor,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      selectedLanguage == 1
                          ? 'Avaible withdrawal'
                          : 'উত্তোলনযোগ্য',
                      style: TextStyle(
                        color: Theme.of(context).highlightColor,
                        fontFamily: 'Roboto Condensed, Ador Noirrit',
                        fontSize: 14,
                      ),
                    ),
                    _isLoading
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Shimmer.fromColors(
                                  baseColor: Theme.of(context).primaryColor,
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
                                    height: 20,
                                    width: MediaQuery.of(context).size.width *
                                        0.30,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                MdiIcons.currencyBdt,
                                color: Theme.of(context).highlightColor,
                                size: 33,
                              ),
                              Text(
                                '$balance',
                                style: TextStyle(
                                  color: Theme.of(context).highlightColor,
                                  fontFamily: 'Roboto Condensed',
                                  fontSize: 32,
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
              Visibility(
                visible: _isLoading == true,
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
                visible: _isDocumentVerified != null &&
                    _isDocumentVerified != "verified",
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 30,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Text(
                        selectedLanguage == 1
                            ? "It's manfatory to upload a PDF your Trade licence and wait for verification before request to withdraw."
                            : "উত্তোলনের পূর্বে ট্রেড লাইসেন্সের পিডিএফ আপলোড করে ভেরিফিকেশন পর্যন্ত অপেক্ষা করা অত্যাবশ্যক।",
                        style: TextStyle(
                          fontFamily: 'Roboto Condensed, Ador Noirrit',
                          color: Theme.of(context).highlightColor,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Business(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColorDark,
                            elevation: 0,
                            padding: EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // <-- Radius
                            ),
                          ),
                          child: Text(
                            selectedLanguage == 1
                                ? 'Go to Business settings'
                                : 'ব্যবসা পরিচিতিতে গমন',
                            style: TextStyle(
                              fontFamily: 'Roboto Condensed, Ador Noirrit',
                              fontSize: 16,
                              color: Theme.of(context).highlightColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Visibility(
                visible:
                    _isDocumentVerified == 'verified' && _isLoading != true,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          counterText: "",
                          helperStyle: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                          ),
                          hintText: selectedLanguage == 1 ? 'Amount' : 'পরিমাণ',
                          hintStyle: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontFamily: 'Roboto Condensed',
                            fontSize: 14,
                          ),
                          labelText: selectedLanguage == 1
                              ? 'Withdraw amount'
                              : 'উত্তোলনের পরিমাণ',
                          labelStyle: TextStyle(
                            fontFamily: 'Roboto Condensed',
                            fontSize: 14,
                            color: Theme.of(context).highlightColor,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColorDark,
                              width: 3,
                              style: BorderStyle.solid,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context).highlightColor,
                              width: 3,
                              style: BorderStyle.solid,
                            ),
                          ),
                          prefixIcon: Icon(
                            MdiIcons.currencyBdt,
                            color: Theme.of(context).highlightColor,
                          ),
                          suffixIcon: Visibility(
                            visible: _amountToWithdraw != null,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: IconButton(
                                onPressed: _fetchMethods,
                                icon: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Theme.of(context).highlightColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        cursorColor: Theme.of(context).highlightColor,
                        style: TextStyle(
                          color: Theme.of(context).highlightColor,
                          fontSize: 22,
                          fontFamily: 'Roboto Condensed',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        maxLength: 6,
                        autocorrect: false,
                        onChanged: (value) {
                          setState(() {
                            _amountToWithdraw = value;
                          });
                        },
                      ),
                      Visibility(
                        visible: withdrawMethos.isNotEmpty,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Theme.of(context).primaryColorDark,
                              width: 3,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: DropdownButtonFormField(
                            items: withdrawMethos.map((e) {
                              return DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e['name'],
                                    style: TextStyle(
                                      fontFamily: 'Roboto Condensed',
                                      fontSize: 14,
                                      color: Theme.of(context).highlightColor,
                                    ),
                                  ));
                            }).toList(),
                            onChanged: (selectedMethod) {
                              setState(() {
                                _selectedMethod = selectedMethod;
                                withdrawCredential = {};
                              });
                            },
                            dropdownColor: Theme.of(context).primaryColorLight,
                            value: _selectedMethod,
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Theme.of(context).highlightColor,
                            ),
                            style: TextStyle(
                              fontFamily: 'Roboto Condensed',
                              fontSize: 14,
                              color: Theme.of(context).highlightColor,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                            ),
                            isExpanded: false,
                            hint: Text(
                              'Select a payment method',
                              style: TextStyle(
                                fontFamily: 'Roboto Condensed',
                                fontSize: 14,
                                color: Theme.of(context).highlightColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: _selectedMethod == null
                            ? SizedBox()
                            : Column(
                                children: [
                                  for (var fields
                                      in _selectedMethod['required'])
                                    Container(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Autocomplete<String>(
                                        optionsBuilder: (TextEditingValue
                                            textEditingValue) {
                                          if (textEditingValue.text.isEmpty ||
                                              fields['suggestion'] == null) {
                                            return Iterable.empty();
                                          } else {
                                            List<String> suggestion =
                                                fields['suggestion']
                                                    .cast<String>();
                                            return suggestion.where((element) =>
                                                element.toLowerCase().contains(
                                                    textEditingValue.text
                                                        .toLowerCase()));
                                          }
                                        },
                                        onSelected: (option) {
                                          setState(() {
                                            withdrawCredential[fields['key']] =
                                                option;
                                          });
                                        },
                                        fieldViewBuilder: (
                                          context,
                                          textEditingController,
                                          focusNode,
                                          onFieldSubmitted,
                                        ) {
                                          return TextFormField(
                                            controller: textEditingController,
                                            focusNode: focusNode,
                                            onEditingComplete: onFieldSubmitted,
                                            style: TextStyle(
                                              fontFamily: 'Roboto Condensed',
                                              color: Theme.of(context)
                                                  .highlightColor,
                                              fontSize: 14,
                                            ),
                                            cursorColor: Theme.of(context)
                                                .highlightColor,
                                            autocorrect: false,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 24.0,
                                                      horizontal: 15.0),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColorDark,
                                                  width: 3,
                                                  style: BorderStyle.solid,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColorDark,
                                                  width: 3,
                                                  style: BorderStyle.solid,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .highlightColor,
                                                  width: 3,
                                                  style: BorderStyle.solid,
                                                ),
                                              ),
                                              hintText: fields['field'],
                                              hintStyle: TextStyle(
                                                fontFamily: 'Roboto Condensed',
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .highlightColor,
                                              ),
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                withdrawCredential[
                                                    fields['key']] = value;
                                              });
                                            },
                                          );
                                        },
                                      ),
                                    )
                                ],
                              ),
                      ),
                      Visibility(
                        visible: _selectedMethod != null,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                              onPressed: _requestWithdraw,
                              child: Text(
                                'Confirm',
                                style: TextStyle(
                                  fontFamily: 'Roboto Condensed',
                                  fontSize: 14,
                                  color: Theme.of(context).highlightColor,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                elevation: 0,
                                padding: EdgeInsets.all(20),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(8), // <-- Radius
                                ),
                                side: BorderSide(
                                  width: 1,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                            ),
                          ],
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

  void _fetchMethods() async {
    var url =
        'https://us-central1-amardokan-5e0da.cloudfunctions.net/app/withdrawmethod';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      withdrawMethos = json;
    });
  }

  void _requestWithdraw() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var url =
          'https://us-central1-amardokan-5e0da.cloudfunctions.net/app/requestwithdraw';
      final uri = Uri.parse(url);
      withdrawCredential['amount'] = _amountToWithdraw;
      withdrawCredential['token'] = token;
      final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(withdrawCredential),
      );
      final body = response.body;
      final json = jsonDecode(body);

      if (json['error'] == 0) {
        setState(() {
          balance = json['newbalance'];
          _amountToWithdraw = '';
          _selectedMethod = null;
          box.put('token', json['token']);
        });
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
                      json['message'],
                      style: TextStyle(
                        fontFamily: 'Roboto Condensed',
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
      } else if (json['error'] == 1) {
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

  Future<void> _handleRefresh() async {
    setState(() {
      _isLoading = true;
    });
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var url =
          'https://us-central1-amardokan-5e0da.cloudfunctions.net/app/balance?token=$token';
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final body = response.body;
      final json = jsonDecode(body);
      if (json['error'] == 0) {
        setState(() {
          _isLoading = false;
          balance = json['balance'];
          _isDocumentVerified = json['document'];
          box.put('token', json['token']);
        });
      } else if (json['error'] == 1) {
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
