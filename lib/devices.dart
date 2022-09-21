import 'dart:convert';
import 'package:agami/Splashscreen.dart';
import 'package:agami/pin.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shimmer/shimmer.dart';

var box = Hive.box('agamiMerchant');

class Devices extends StatefulWidget {
  const Devices({Key? key}) : super(key: key);

  @override
  State<Devices> createState() => _DevicesState();
}

class _DevicesState extends State<Devices> {
  var selectedLanguage = box.get('language', defaultValue: 1);
  var token = box.get('token', defaultValue: 'null');
  var isLoading = false;
  List deviceList = [];

  @override
  void initState() {
    _handleRefresh();
    super.initState();
  }

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
                      selectedLanguage == 1 ? 'Devices' : 'ডিভাইস',
                      style: TextStyle(
                        color: Theme.of(context).highlightColor,
                        fontFamily: 'Roboto Condensed, Ador Noirrit',
                        fontSize: 22,
                      ),
                    ),
                    IconButton(
                      onPressed: _handleRefresh,
                      icon: Icon(
                        Icons.refresh_outlined,
                        color: Theme.of(context).highlightColor,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      alignment: AlignmentGeometry.lerp(
                          Alignment.center, Alignment.center, 0),
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Container(
                        height: 145,
                        width: 145,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 34, 34, 34),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 150,
                      color: const Color.fromARGB(255, 34, 34, 34),
                    ),
                    Container(
                      height: 150,
                      width: 100,
                      color: const Color.fromARGB(255, 34, 34, 34),
                    ),
                    IconButton(
                      onPressed: _scanForDevice,
                      color: Colors.white,
                      iconSize: 32,
                      icon: const Icon(
                        Icons.add_to_queue_outlined,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 22, bottom: 14),
                child: Column(
                  children: [
                    Text(
                      selectedLanguage == 1
                          ? 'Use Agami Pay on web by scaning QR'
                          : 'ওয়েবে আগামি মার্চেন্ট ব্যবহার করতে কিউআর স্ক্যান করুন',
                      style: TextStyle(
                        fontFamily: 'Roboto Condensed, Ador Noirrit',
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).highlightColor,
                      ),
                    ),
                    Text(
                      selectedLanguage == 1
                          ? 'To log out tap a device from list'
                          : 'লগ-আউট করতে ডিভাইসের উপর স্পর্শ করুন',
                      style: TextStyle(
                        fontFamily: 'Roboto Condensed, Ador Noirrit',
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).highlightColor,
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: isLoading,
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          height: 10,
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
                          height: 10,
                          width: 250,
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
                          height: 10,
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
                          height: 10,
                          width: 250,
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
                          height: 10,
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
                          height: 10,
                          width: 250,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: isLoading == false,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      for (var device in deviceList)
                        Wrap(
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      content: Wrap(
                                        direction: Axis.vertical,
                                        children: [
                                          Text(
                                            device['device'],
                                            style: TextStyle(
                                              fontFamily: 'Roboto Condensed',
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .highlightColor,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 5,
                                            ),
                                            child: Text(
                                              device['time'],
                                              style: TextStyle(
                                                fontFamily: 'Roboto Condensed',
                                                fontSize: 12,
                                                color:
                                                    Theme.of(context).hintColor,
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            thickness: 1,
                                            color: Colors.transparent,
                                          ),
                                          Wrap(
                                            direction: Axis.horizontal,
                                            alignment: WrapAlignment.end,
                                            children: [
                                              OutlinedButton(
                                                onPressed: () {
                                                  _disposeDevice(device['id']);
                                                },
                                                style: OutlinedButton.styleFrom(
                                                  side: BorderSide(
                                                    width: 1,
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  ),
                                                ),
                                                child: Text(
                                                  'Logout',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Roboto Condensed, Ador Noirrit',
                                                    fontSize: 14,
                                                    color: Theme.of(context)
                                                        .highlightColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      child: Icon(
                                        Icons.important_devices_outlined,
                                        color: Theme.of(context).highlightColor,
                                        size: 32,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2),
                                          child: Text(
                                            device['device'],
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .highlightColor,
                                              fontFamily: 'Roboto Condensed',
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2),
                                          child: Text(
                                            device['time'],
                                            style: TextStyle(
                                              color:
                                                  Theme.of(context).hintColor,
                                              fontFamily: 'Roboto Condensed',
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible:
                                  device == deviceList[deviceList.length - 1]
                                      ? false
                                      : true,
                              child: Divider(
                                color: Theme.of(context).highlightColor,
                                thickness: 0.1,
                              ),
                            ),
                          ],
                        )
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

  Future<void> _handleRefresh() async {
    setState(() {
      isLoading = true;
    });
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && token != null) {
      var url =
          'https://us-central1-amardokan-5e0da.cloudfunctions.net/app/devices?token=$token';
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final body = response.body;
      final json = jsonDecode(body);
      if (json['error'] == 0) {
        box.put('token', json['token']);
        setState(() {
          deviceList = json['devices'];
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

  void _scanForDevice() async {
    var barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#000000', 'Cancel', false, ScanMode.QR);
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && token != null) {
      var url =
          'https://us-central1-amardokan-5e0da.cloudfunctions.net/app/newdevice?token=$token&qr=$barcodeScanRes';
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final body = response.body;
      final json = jsonDecode(body);
      if (json['error'] == 0) {
        box.put('token', json['token']);
        setState(() {
          deviceList = json['devices'];
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

  void _disposeDevice(device) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && token != null) {
      var url =
          'https://us-central1-amardokan-5e0da.cloudfunctions.net/app/disposedevice?token=$token&device=$device';
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final body = response.body;
      final json = jsonDecode(body);
      if (json['error'] == 0) {
        box.put('token', json['token']);
        setState(() {
          deviceList = json['devices'];
        });
        Navigator.of(context).pop();
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
