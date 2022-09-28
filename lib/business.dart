import 'dart:convert';
import 'package:agami/Splashscreen.dart';
import 'package:agami/pin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
  final token = box.get('token', defaultValue: 'null');
  String? avatar = FirebaseAuth.instance.currentUser!.photoURL;
  List businessDetails = [];

  @override
  void initState() {
    _handleRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).primaryColor,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Theme.of(context).primaryColor,
    );
    SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: SafeArea(
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
                          final phonenumber =
                              FirebaseAuth.instance.currentUser!.phoneNumber;
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Theme.of(context).primaryColor,
                                content: QrImage(
                                  data:
                                      'https://agamimerchant.com/$phonenumber',
                                  version: QrVersions.auto,
                                  padding: EdgeInsets.all(20),
                                  foregroundColor:
                                      Theme.of(context).highlightColor,
                                ),
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
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundImage: const AssetImage(
                                    'assets/default-photo.png'),
                                backgroundColor: Theme.of(context).primaryColor,
                                foregroundImage: NetworkImage('$avatar'),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    businessDetails.isEmpty
                                        ? Shimmer.fromColors(
                                            baseColor: Theme.of(context)
                                                .primaryColorDark,
                                            highlightColor: Theme.of(context)
                                                .primaryColorLight,
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                vertical: 5,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColorDark,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  50,
                                                ),
                                              ),
                                              height: 14,
                                              width: double.infinity,
                                            ),
                                          )
                                        : Text(
                                            businessDetails[0]['title'],
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .highlightColor,
                                              fontFamily:
                                                  'Roboto Condensed, Ador Noirrit',
                                              fontSize: 18,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                    businessDetails.isEmpty
                                        ? Shimmer.fromColors(
                                            baseColor: Theme.of(context)
                                                .primaryColorDark,
                                            highlightColor: Theme.of(context)
                                                .primaryColorLight,
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                vertical: 5,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColorDark,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  50,
                                                ),
                                              ),
                                              height: 14,
                                              width: 100,
                                            ),
                                          )
                                        : Text(
                                            businessDetails[0]['owner'],
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .highlightColor,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        selectedLanguage == 1
                                            ? 'Phone number'
                                            : 'মোবাইল নম্বর',
                                        style: TextStyle(
                                          color:
                                              Theme.of(context).highlightColor,
                                          fontFamily:
                                              'Roboto Condensed, Ador Noirrit',
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        '01725-523652',
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
                        businessDetails.isEmpty
                            ? Visibility(
                                visible: businessDetails.isNotEmpty,
                                child: Shimmer.fromColors(
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
                                    height: 14,
                                    width: 100,
                                  ),
                                ))
                            : Visibility(
                                visible: businessDetails.isEmpty ||
                                    businessDetails[0]['address'].length > 0,
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
                                                  businessDetails[0]['address'],
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .highlightColor,
                                                    fontFamily:
                                                        'Roboto Condensed',
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
                        //business documents
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
                                            color: Theme.of(context)
                                                .highlightColor,
                                            fontFamily:
                                                'Roboto Condensed, Ador Noirrit',
                                            fontSize: 14,
                                          ),
                                        ),
                                        businessDetails.isEmpty
                                            ? Shimmer.fromColors(
                                                baseColor: Theme.of(context)
                                                    .primaryColorDark,
                                                highlightColor:
                                                    Theme.of(context)
                                                        .primaryColorLight,
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                    vertical: 5,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .primaryColorDark,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      50,
                                                    ),
                                                  ),
                                                  height: 14,
                                                  width: double.infinity,
                                                ),
                                              )
                                            : Text(
                                                selectedLanguage == 1 &&
                                                        businessDetails[0]
                                                                ['document'] ==
                                                            'verified'
                                                    ? 'Trade license verified'
                                                    : selectedLanguage == 1 &&
                                                            businessDetails[0][
                                                                    'document'] !=
                                                                'verified'
                                                        ? 'Trade license not verified'
                                                        : selectedLanguage ==
                                                                    2 &&
                                                                businessDetails[
                                                                            0][
                                                                        'document'] ==
                                                                    'verified'
                                                            ? 'ট্রেড লাইসেন্স প্রতিপাদিত'
                                                            : 'ট্রেড লাইসেন্স প্রতিপাদিত হয়নি',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .highlightColor,
                                                  fontFamily:
                                                      'Roboto Condensed',
                                                  fontSize: 18,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                                businessDetails.isEmpty
                                    ? Shimmer.fromColors(
                                        baseColor:
                                            Theme.of(context).primaryColorDark,
                                        highlightColor:
                                            Theme.of(context).primaryColorLight,
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                            borderRadius: BorderRadius.circular(
                                              50,
                                            ),
                                          ),
                                          height: 14,
                                          width: 20,
                                        ),
                                      )
                                    : Row(
                                        children: [
                                          Visibility(
                                            visible: businessDetails[0]
                                                    ['document'] !=
                                                'verified',
                                            child: IconButton(
                                              onPressed: _pickFile,
                                              icon: Icon(
                                                Icons.cloud_upload_outlined,
                                                color: Theme.of(context)
                                                    .highlightColor,
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: businessDetails[0]
                                                    ["document"] ==
                                                'verified',
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.done_rounded,
                                                color: Theme.of(context)
                                                    .indicatorColor,
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

  Future<void> _handleRefresh() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var url =
          'https://us-central1-amardokan-5e0da.cloudfunctions.net/app/business?token=$token';
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final body = response.body;
      final json = jsonDecode(body);
      if (json['error'] == 0) {
        setState(() {
          businessDetails = json['details'];
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
