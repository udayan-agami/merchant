import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class Business extends StatefulWidget {
  const Business({Key? key}) : super(key: key);

  @override
  State<Business> createState() => _BusinessState();
}

class _BusinessState extends State<Business> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050933),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
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
                      'Business Details',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto Condensed',
                        fontSize: 22,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  constraints: BoxConstraints(
                                    maxWidth: MediaQuery.of(context).size.width,
                                    maxHeight:
                                        MediaQuery.of(context).size.height,
                                  ),
                                  child: Column(
                                    children: [
                                      Image.network(
                                        'https://i.ibb.co/Hnjc3bJ/image.png',
                                      ),
                                      SizedBox(
                                        child: Icon(Icons.download),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      icon: Icon(
                        Icons.qr_code_outlined,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFF181D5A),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
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
                                      color: Colors.white,
                                      fontFamily: 'Roboto Condensed',
                                      fontSize: 18,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Anam Sarkar',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Roboto Condensed',
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
                        color: Colors.white,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xFF050933),
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
                                      'Phone number',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Roboto Condensed',
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      '01725-523652',
                                      style: TextStyle(
                                        color: Colors.white,
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
                                  color: Colors.lightGreenAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xFF050933),
                        ),
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 0),
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
                                        'Address',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Roboto Condensed',
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        'AKS tower, Lalmonir hat, Beside choto bridege, Gazipur AKS tower, Lalmonir hat, Beside choto bridege, Gazipur',
                                        style: TextStyle(
                                          color: Colors.white,
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
                      //NID
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xFF050933),
                        ),
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
                                        'Legal documents',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Roboto Condensed',
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        'NID card not verified',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Roboto Condensed',
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.done_rounded,
                                  color: Colors.lightGreenAccent,
                                ),
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
}
