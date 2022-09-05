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
                      'Business Details',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto Condensed',
                        fontSize: 22,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.share,
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ma enterprize and co.',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Roboto Condensed',
                                      fontSize: 18),
                                ),
                                Text(
                                  'Anam Sarkar',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Roboto Condensed',
                                      fontSize: 14),
                                ),
                              ],
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
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xFF050933),
                        ),
                        margin: EdgeInsets.only(top: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      overflow: TextOverflow.fade,
                                      softWrap: false,
                                    ),
                                  ],
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
