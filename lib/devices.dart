import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class Devices extends StatefulWidget {
  const Devices({Key? key}) : super(key: key);

  @override
  State<Devices> createState() => _DevicesState();
}

class _DevicesState extends State<Devices> {
  List deviceList = [
    {
      "title": "Chrome (Windows)",
      "subtitle": "Activated on 13 July 2022 at 4.20 PM"
    },
    {
      "title": "Opera (Windows)",
      "subtitle": "Activated on 25 July 2022 at 4.20 PM"
    },
    {
      "title": "Safari (Windows)",
      "subtitle": "Activated on 13 Septembar 2022 at 4.20 PM"
    },
    {
      "title": "Chrome (Windows)",
      "subtitle": "Activated on 13 July 2022 at 4.20 PM"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050933),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF181D5A),
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
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    const Text(
                      'Devices',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto Condensed',
                        fontSize: 22,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
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
                          color: Color.fromARGB(255, 34, 34, 34),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 150,
                      color: Color.fromARGB(255, 34, 34, 34),
                    ),
                    Container(
                      height: 150,
                      width: 100,
                      color: Color.fromARGB(255, 34, 34, 34),
                    ),
                    IconButton(
                      onPressed: () {},
                      color: Colors.white,
                      iconSize: 32,
                      icon: Icon(
                        Icons.install_desktop_outlined,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 22, bottom: 14),
                child: Column(
                  children: [
                    Text(
                      'Use Agami Pay on web by scaning QR',
                      style: TextStyle(
                        fontFamily: 'Roboto Condensed',
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'To log out tap a device from list',
                      style: TextStyle(
                        fontFamily: 'Roboto Condensed',
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF181D5A),
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    for (var device in deviceList)
                      Wrap(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  child: Icon(
                                    Icons.computer,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(2),
                                      child: Text(
                                        device['title'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Roboto Condensed',
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(2),
                                      child: Text(
                                        device['subtitle'],
                                        style: TextStyle(
                                          color: Colors.grey,
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
                          Visibility(
                            visible: device == deviceList[deviceList.length - 1]
                                ? false
                                : true,
                            child: Divider(
                              color: Colors.white,
                              thickness: 0.1,
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
