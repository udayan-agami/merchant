import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Pin extends StatefulWidget {
  const Pin({Key? key}) : super(key: key);

  @override
  State<Pin> createState() => _PinState();
}

class _PinState extends State<Pin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050933),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    'Input PIN',
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
            Column(
              children: [
                SizedBox(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: Color.fromARGB(48, 255, 255, 255),
                      ),
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: Color.fromARGB(48, 255, 255, 255),
                      ),
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: Color.fromARGB(48, 255, 255, 255),
                      ),
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: Color.fromARGB(48, 255, 255, 255),
                      ),
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: Color.fromARGB(48, 255, 255, 255),
                      ),
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: Color.fromARGB(48, 255, 255, 255),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot PIN',
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Roboto Condensed',
                        fontSize: 16,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        width: 1,
                        color: Colors.grey,
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color.fromARGB(48, 255, 255, 255),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          '1',
                          style: TextStyle(
                            fontFamily: 'Roboto Condensed',
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 30,
                          ),
                          elevation: 0,
                          primary: Colors.transparent,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          '2',
                          style: TextStyle(
                            fontFamily: 'Roboto Condensed',
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          splashFactory: NoSplash.splashFactory,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 30,
                          ),
                          elevation: 0,
                          primary: Colors.transparent,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          '3',
                          style: TextStyle(
                            fontFamily: 'Roboto Condensed',
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 30,
                          ),
                          elevation: 0,
                          primary: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          '4',
                          style: TextStyle(
                            fontFamily: 'Roboto Condensed',
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 30,
                          ),
                          elevation: 0,
                          primary: Colors.transparent,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          '5',
                          style: TextStyle(
                            fontFamily: 'Roboto Condensed',
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 30,
                          ),
                          elevation: 0,
                          primary: Colors.transparent,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          '6',
                          style: TextStyle(
                            fontFamily: 'Roboto Condensed',
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 30,
                          ),
                          elevation: 0,
                          primary: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          '7',
                          style: TextStyle(
                            fontFamily: 'Roboto Condensed',
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 30,
                          ),
                          elevation: 0,
                          primary: Colors.transparent,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          '8',
                          style: TextStyle(
                            fontFamily: 'Roboto Condensed',
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 30,
                          ),
                          elevation: 0,
                          primary: Colors.transparent,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          '9',
                          style: TextStyle(
                            fontFamily: 'Roboto Condensed',
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 30,
                          ),
                          elevation: 0,
                          primary: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        padding: EdgeInsets.all(23),
                        splashRadius: 32,
                        onPressed: () {},
                        icon: Icon(
                          Icons.backspace_outlined,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          '0',
                          style: TextStyle(
                            fontFamily: 'Roboto Condensed',
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 30,
                          ),
                          elevation: 0,
                          primary: Colors.transparent,
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.all(23),
                        splashRadius: 32,
                        onPressed: () {},
                        icon: Icon(
                          Icons.done,
                          color: Colors.lightGreenAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
