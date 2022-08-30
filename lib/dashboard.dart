import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF050933),
        bottomNavigationBar: CurvedNavigationBar(
          height: 60,
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: const Color(0xFF050933),
          buttonBackgroundColor: const Color(0xFF434B96),
          color: const Color(0xFF434B96),
          items: const <Widget>[
            Icon(
              Icons.list_alt_rounded,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.space_dashboard_rounded,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.face_outlined,
              size: 30,
              color: Colors.white,
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              color: const Color(0xFF050933),
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    backgroundImage:
                        NetworkImage('https://i.ibb.co/stQv06t/unnamed.jpg'),
                    backgroundColor: Color(0xFF181D5A),
                  ),
                  Container(
                    alignment: Alignment.center,
                    color: const Color(0xFF050933),
                    child: const Text(
                      'Dashboard',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontFamily: 'Roboto Condensed'),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_outlined),
                    color: Colors.white,
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 28),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xFF181D5A),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(' '),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(
                          MdiIcons.currencyBdt,
                          color: Colors.white,
                          size: 16,
                        ),
                        Text('5672.25',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                                fontFamily: 'Roboto Condensed'))
                      ],
                    ),
                    Column(
                      children: const [
                        Icon(
                          Icons.trending_up_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        Text(
                          '10%',
                          style: TextStyle(
                              fontFamily: 'Roboto Condensed',
                              fontSize: 14,
                              color: Colors.white),
                        )
                      ],
                    )
                  ]),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xFF181D5A),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: const [
                          Text(
                            'Pending',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto Condensed',
                                fontSize: 14),
                          ),
                          Text(
                            '4',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto Condensed',
                                fontSize: 28),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        child: Stack(
                      children: [
                        Container(
                          color: const Color(0xFF050933),
                          width: 10,
                          height: 76,
                        ),
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: const Color(0xFF050933),
                          ),
                        )
                      ],
                    )),
                    Expanded(
                      child: Column(
                        children: const [
                          Text(
                            'Paid',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto Condensed',
                                fontSize: 14),
                          ),
                          Text(
                            '41',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto Condensed',
                                fontSize: 28),
                          ),
                        ],
                      ),
                    )
                  ]),
            )
          ],
        ));
  }
}
