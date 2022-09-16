import 'dart:convert';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

var box = Hive.box('agamiMerchant');
var storage = FirebaseStorage.instance;
FirebaseAuth auth = FirebaseAuth.instance;

class Business extends StatefulWidget {
  const Business({Key? key}) : super(key: key);

  @override
  State<Business> createState() => _BusinessState();
}

class _BusinessState extends State<Business> {
  var selectedLanguage = box.get('language', defaultValue: 1);
  List businessDetails = [
    {"address": "", "document": "pending"}
  ];
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
                      onPressed: () async {
                        var storageRef = storage.ref();
                        final uid = FirebaseAuth.instance.currentUser!.uid;
                        final imageUrl = await storageRef
                            .child("banner")
                            .child("banner-$uid.jpg")
                            .getDownloadURL();
                        print(imageUrl);
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Theme.of(context).primaryColor,
                              content: Image.network(imageUrl),
                            );
                          },
                        );
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
                      Visibility(
                        visible: businessDetails[0]['address'].length > 0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Theme.of(context).primaryColorDark,
                          ),
                          margin: const EdgeInsets.only(top: 8),
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
                                            color: Theme.of(context)
                                                .highlightColor,
                                            fontFamily:
                                                'Roboto Condensed, Ador Noirrit',
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          'AKS tower, Lalmonir hat, Beside choto bridege, Gazipur AKS tower, Lalmonir hat, Beside choto bridege, Gazipur',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .highlightColor,
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
                      ),
                      //NID
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context).primaryColorDark,
                        ),
                        margin: const EdgeInsets.only(top: 8),
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
                                        selectedLanguage == 1 &&
                                                businessDetails[0]
                                                        ['document'] ==
                                                    'verified'
                                            ? 'Trade license verified'
                                            : selectedLanguage == 1 &&
                                                    businessDetails[0]
                                                            ['document'] !=
                                                        'verified'
                                                ? 'Trade license not verified'
                                                : selectedLanguage == 2 &&
                                                        businessDetails[0]
                                                                ['document'] ==
                                                            'verified'
                                                    ? 'ট্রেড লাইসেন্স প্রতিপাদিত'
                                                    : 'ট্রেড লাইসেন্স প্রতিপাদিত হয়নি',
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
                              Row(
                                children: [
                                  Visibility(
                                    visible: businessDetails[0]['document'] !=
                                        'verified',
                                    child: IconButton(
                                      onPressed: _pickFile,
                                      icon: Icon(
                                        Icons.cloud_upload_outlined,
                                        color: Theme.of(context).highlightColor,
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: businessDetails[0]["document"] ==
                                        'verified',
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.done_rounded,
                                        color: Theme.of(context).indicatorColor,
                                      ),
                                    ),
                                  ),
                                ],
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

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'doc', 'png'],
        allowMultiple: false);

    if (result != null && result.files.isNotEmpty) {
      List single = result.files;
      final fileBytes = single[0].bytes;
      final fileExt = single[0].extension;
      final phone = FirebaseAuth.instance.currentUser!.phoneNumber;
      final parsedPhone = phone!.split('+')[1];
      final fileName = 'doc-$parsedPhone.$fileExt';

      // upload file
      await FirebaseStorage.instance
          .ref('documents/$fileName')
          .putData(fileBytes);
    }
  }
}
