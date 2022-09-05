import 'package:flutter/material.dart';

class Withdraw extends StatefulWidget {
  const Withdraw({Key? key}) : super(key: key);

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050933),
      body: SafeArea(
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
                    'Withdraw',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Roboto Condensed',
                      fontSize: 22,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 24,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF181D5A),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Avaible withdrawal',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto Condensed',
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '652196',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto Condensed',
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 24,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF181D5A),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Pending clearance',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto Condensed',
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '7500',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto Condensed',
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 24,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF181D5A),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Total Cleared',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto Condensed',
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '98523',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto Condensed',
                              fontSize: 24,
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
    );
  }
}
