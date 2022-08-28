import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agami Merchant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: const Color(0xFF2D2F41),
        ),
        Container(
          margin: const EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFF42455E),
          ),
        ),
        Container(
          child: IconButton(
            icon: const Icon(Icons.lightbulb_outline_rounded),
            onPressed: () {},
            color: Colors.white,
          ),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.amber, width: 5, style: BorderStyle.solid)),
        ),
        CustomPaint(
          painter: WirePainter(),
        ),
      ],
    ));
  }
}

class WirePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint linepaint = Paint();
    linepaint.strokeWidth = 6;
    linepaint.color = const Color(0xFF2D2F41);
    linepaint.style = PaintingStyle.stroke;
    linepaint.strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(8, size.width), const Offset(100, 100), linepaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
