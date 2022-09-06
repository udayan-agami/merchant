import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        MdiIcons.currencyBdt,
                        color: Colors.white,
                        size: 33,
                      ),
                      Text(
                        '652196',
                        style: TextStyle(
                          color: Colors.white,
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
                color: const Color(0xFF181D5A),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                  helperStyle: TextStyle(
                    color: const Color(0xFF434B96),
                  ),
                  hintText: 'Amount',
                  hintStyle: TextStyle(
                    color: Colors.blueGrey,
                    fontFamily: 'Roboto Condensed',
                    fontSize: 32,
                  ),
                  labelText: 'Withdraw amount',
                  labelStyle: TextStyle(
                    fontFamily: 'Roboto Condensed',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: const Color(0xFF434B96),
                      width: 3,
                      style: BorderStyle.solid,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 3,
                      style: BorderStyle.solid,
                    ),
                  ),
                  prefixIcon: Icon(
                    MdiIcons.currencyBdt,
                    color: Colors.white,
                  ),
                  suffixIcon: IconButton(
                    color: Colors.white,
                    onPressed: () {},
                    icon: Icon(
                      Icons.next_plan_outlined,
                      color: Colors.white,
                    ),
                    iconSize: 30,
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontFamily: 'Roboto Condensed',
                ),
                keyboardType: TextInputType.number,
                maxLength: 6,
                autocorrect: false,
              ),
            )
          ],
        ),
      ),
    );
  }
}
