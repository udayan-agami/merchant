import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

var box = Hive.box('agamiMerchant');

class Withdraw extends StatefulWidget {
  const Withdraw({Key? key}) : super(key: key);

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  var selectedLanguage = box.get('language', defaultValue: 1);
  List test = [
    {"name": "koliog"},
    {"name": "jafru"}
  ];
  List withdrawMethos = [];
  var _selectedMethod;
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
                      onPressed: () {},
                      icon: Icon(
                        Icons.done,
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          MdiIcons.currencyBdt,
                          color: Theme.of(context).highlightColor,
                          size: 33,
                        ),
                        Text(
                          '652196',
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
              Container(
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
                        suffixIcon: IconButton(
                          onPressed: _fetchMethods,
                          icon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Theme.of(context).highlightColor,
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
                      maxLength: 6,
                      autocorrect: false,
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
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10)),
                          isExpanded: true,
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
                                for (var fields in _selectedMethod['required'])
                                  Container(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Autocomplete<String>(
                                      optionsBuilder:
                                          (TextEditingValue textEditingValue) {
                                        if (textEditingValue.text.isEmpty ||
                                            fields['suggestion'].length == 0 ||
                                            fields['suggestion'] == null) {
                                          return Iterable.empty();
                                        } else {
                                          List<String> suggestion =
                                              fields['suggestion'];
                                          return suggestion.where((element) =>
                                              element.toLowerCase().contains(
                                                  textEditingValue.text
                                                      .toLowerCase()));
                                        }
                                      },
                                      fieldViewBuilder: (context,
                                          textEditingController,
                                          focusNode,
                                          onFieldSubmitted) {
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
                                          cursorColor:
                                              Theme.of(context).highlightColor,
                                          autocorrect: false,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 24.0,
                                                    horizontal: 10.0),
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
                            onPressed: () {},
                            child: Text(
                              'Confirm',
                              style: TextStyle(
                                fontFamily: 'Roboto Condensed',
                                fontSize: 14,
                                color: Theme.of(context).highlightColor,
                              ),
                            ),
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
                          ),
                        ],
                      ),
                    ),
                  ],
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
}
